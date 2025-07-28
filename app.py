from flask import Flask, make_response, render_template, request, redirect, url_for, flash, Response, jsonify,session
from flask_sqlalchemy import SQLAlchemy
from datetime import date, datetime
import secrets
from functools import wraps
from sqlalchemy import text
from flask_migrate import Migrate
import os
import io
from models import  Attendee, AttendanceRecord, PhanerooService, Center
from extensions import db
from dotenv import load_dotenv



load_dotenv()

app = Flask(__name__)

db_uri = os.getenv('DATABASE_URL')
if db_uri and db_uri.startswith('postgresql://'):
    db_uri = db_uri.replace('postgresql://', 'postgresql+psycopg2://', 1)


app.config["SQLALCHEMY_DATABASE_URI"] = db_uri
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.secret_key = os.getenv("SECRET_KEY")  # Flask uses this
app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")  # Also set here for extensions that may use it





db = SQLAlchemy(app)
migrate = Migrate(app, db)


def login_required(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        if not session.get('authenticated'):
            return redirect(url_for('home'))
        return f(*args, **kwargs)
    return wrapper

# Generate a random secret key (just once if needed)
print(secrets.token_hex(16))

  # Load environment variables from .env file




with app.app_context():
    try:
        with db.engine.connect() as conn:
            result = conn.execute(text('SELECT 1'))  # <-- wrap query with text()
            print('Database connection successful:', result.fetchone())
    except Exception as e:
        print('Database connection failed:', e)

ACCESS_PASSWORD = '123'


# ------------------- MODELS -------------------

class Center(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)
    members = db.relationship('Member', backref='center', lazy=True)
    souls = db.relationship('Soul', backref='center', lazy=True)
    attendances = db.relationship('Attendance', backref='center', lazy=True)

class Member(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    gender = db.Column(db.String(10), nullable=True)
    contact = db.Column(db.String(20))
    residence = db.Column(db.String(100))
    home_district = db.Column(db.String(100), nullable=True)
    marital_status = db.Column(db.String(20), nullable=True)
    course_Profession = db.Column(db.String(100))
    year_of_study = db.Column(db.String(20), nullable=True)
    first_time = db.Column(db.String(10))  # 'Yes' or 'No'
    center_id = db.Column(db.Integer, db.ForeignKey('center.id'), nullable=False)
    # center = db.relationship('Center', backref='members')
    attendances = db.relationship('Attendance', backref='member', lazy=True)

class Attendance(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    service_number = db.Column(db.Integer, nullable=False)
    service_date = db.Column(db.Date)
    member_id = db.Column(db.Integer, db.ForeignKey('member.id'), nullable=False)
    center_id = db.Column(db.Integer, db.ForeignKey('center.id'), nullable=False)
    first_time = db.Column(db.String(10))  # 'Yes' or 'No'





class Soul(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    contact = db.Column(db.String(10), nullable=False)
    residence = db.Column(db.String(100), nullable=False)
    first_time = db.Column(db.String(10), nullable=True)
    service_number = db.Column(db.Integer, nullable=True)
    service_date = db.Column(db.Date, default=date.today, nullable=True)
    outreach_date = db.Column(db.Date, nullable=True)
    source = db.Column(db.String(20))
    center_id = db.Column(db.Integer, db.ForeignKey('center.id'), nullable=False)

# ------------------- UTILITY -------------------

def get_centers_and_selected():
    centers = Center.query.order_by(Center.name).all()
    if not centers:
        default_names = ['Main Campus', 'Nyabikoni', 'Little Ritz']
        for name in default_names:
            db.session.add(Center(name=name))
        db.session.commit()
        centers = Center.query.order_by(Center.name).all()
    selected_center_id = request.args.get('center_id', type=int) or centers[0].id
    return centers, selected_center_id

# ------------------- ROUTES -------------------

@app.route('/',methods=['GET', 'POST'])
def home():
    if request.method == 'POST':
        password = request.form['password']
        if password == ACCESS_PASSWORD:
            session['authenticated'] = True
            flash('Access granted!', 'success')
            return redirect(url_for('home'))
        else:
            flash('Invalid password. Please try again.', 'danger')
            return redirect(url_for('home'))
    return render_template('home.html')

@app.route('/attendance', methods=['GET', 'POST'])
@login_required
def attendance():
    centers, selected_center_id = get_centers_and_selected()

    # Get from args or form
    center_id_value = request.form.get('center_id') or request.args.get('center_id')
    if center_id_value and center_id_value.isdigit():
        selected_center_id = int(center_id_value)

    selected_service = request.form.get('service_number') or request.args.get('service_number')
    service_numbers_raw = db.session.query(Attendance.service_number).distinct().all()
    service_numbers = [sn[0] for sn in service_numbers_raw]
    records = []

    first_timers_count = 0

    if selected_service and selected_service.isdigit():
        selected_service = int(selected_service)
        records = Attendance.query.filter_by(service_number=selected_service, center_id=selected_center_id).all()
        first_timers_count = sum(1 for r in records if r.first_time and r.first_time.strip().lower() == 'Yes')


        if request.form.get('export') == 'csv':
            def generate_csv():
                data = [['Name', 'Contact', 'Residence', 'Course', 'First Time', 'Date']]
                for record in records:
                    data.append([
                        record.member.name,
                        record.member.contact or '',
                        record.member.residence or '',
                        record.member.course_Profession or '',
                        record.first_time or '',
                        record.service_date.strftime('%Y-%m-%d') if record.service_date else ''
                    ])
                return '\n'.join([','.join(f'"{item}"' for item in row) for row in data])

            csv_data = generate_csv()
            return Response(
                csv_data,
                mimetype='text/csv',
                headers={"Content-Disposition": f"attachment;filename=attendance_service_{selected_service}.csv"}
            )

    return render_template(
        'view_attendance.html',
        centers=centers,
        selected_center_id=selected_center_id,
        service_numbers=service_numbers,
        selected_service=selected_service,
        records=records,
        first_timers_count=first_timers_count
    )


@app.route('/delete_attendance', methods=['POST'])
@login_required
def delete_attendance():
    ids_to_delete = request.form.getlist('delete_ids')
    selected_center_id = request.form.get('center_id')
    selected_service = request.form.get('service_number')

    if ids_to_delete:
        try:
            Attendance.query.filter(Attendance.id.in_(ids_to_delete)).delete(synchronize_session=False)
            db.session.commit()
            flash(f"Deleted {len(ids_to_delete)} record(s).", "success")
        except Exception as e:
            db.session.rollback()
            flash("An error occurred while deleting.", "danger")
    else:
        flash("No records selected.", "warning")

    # Redirect back to /attendance with selected center and service
    return redirect(url_for('attendance', center_id=selected_center_id, service_number=selected_service))





@app.route('/register', methods=['GET', 'POST'])
@login_required
def register():
    centers, selected_center_id = get_centers_and_selected()
    if request.method == 'POST':
        center_id = int(request.form.get('center_id', selected_center_id))
        name = request.form.get('name')
        gender = request.form.get('gender')
        contact = request.form.get('contact', '').strip()
        residence = request.form.get('residence')
        home_district = request.form.get('home_district')
        marital_status = request.form.get('marital_status')
        course_Profession = request.form.get('course_Profession')
        year_of_study = request.form.get('year_of_study')
        first_time = request.form.get('first_time')
       

        if not (contact.isdigit() and len(contact) == 10):
            flash("Phone number must be exactly 10 digits.", "danger")
            return redirect(url_for('register'))

        if not name or not first_time:
            flash('Name and First Time fields are required.', 'danger')
            return redirect(url_for('register'))

        new_member = Member(
            name=name, contact=contact, residence=residence,
            course_Profession=course_Profession, first_time=first_time, center_id=center_id,
            year_of_study=year_of_study,gender=gender,
            home_district=home_district, marital_status=marital_status
        )
        db.session.add(new_member)
        db.session.commit()
        flash('Member registered successfully!', 'success')
        return redirect(url_for('register', center_id=center_id))

    return render_template('register.html', centers=centers, selected_center_id=selected_center_id)

from datetime import datetime

@app.route('/mark_attendance', methods=['GET', 'POST'])
@login_required
def mark_attendance():
    centers, selected_center_id = get_centers_and_selected()
    members = Member.query.order_by(Member.name).all()
    member_dict = {member.name: member.id for member in members}
    member_names = list(member_dict.keys())

    center_id = int(request.form.get('center_id', selected_center_id))

    if request.method == 'POST':
        service_number = request.form.get('service_number')
        member_id = request.form.get('member_id')
        service_date_str = request.form.get('service_date')

        # Validation
        if not service_number or not service_number.isdigit():
            flash('Please enter a valid service number.', 'danger')
            return redirect(url_for('mark_attendance'))

        if not member_id or not member_id.isdigit():
            flash('Please select a valid member from the suggestions.', 'danger')
            return redirect(url_for('mark_attendance'))

        if not service_date_str:
            flash('Please select a service date.', 'danger')
            return redirect(url_for('mark_attendance'))

        try:
            service_date = datetime.strptime(service_date_str, '%Y-%m-%d').date()
        except ValueError:
            flash('Invalid service date format.', 'danger')
            return redirect(url_for('mark_attendance'))

        service_number = int(service_number)
        member_id = int(member_id)

        existing_record = Attendance.query.filter_by(service_number=service_number, member_id=member_id).first()
        if existing_record:
            flash('Attendance for this member has already been recorded for this service.', 'warning')
        else:
            prior_attendance = Attendance.query.filter_by(member_id=member_id).first()
            first_time_value = "Yes" if not prior_attendance else "No"

            attendance = Attendance(
                service_number=service_number,
                service_date=service_date,
                member_id=member_id,
                center_id=center_id,
                first_time=first_time_value
            )
            db.session.add(attendance)
            db.session.commit()
            flash('Attendance marked successfully!', 'success')

        return redirect(url_for('mark_attendance'))  # Only redirect after form processing!

    # This is only reached for GET requests (form rendering)
    return render_template(
        'mark_attendance.html',
        member_names=member_names,
        member_dict=member_dict,
        centers=centers,
        selected_center_id=center_id
    )



@app.route('/search_members')
def search_members():
    query = request.args.get('q', '').strip()
    if not query:
        return jsonify([])
    results = Member.query.filter(Member.name.ilike(f"%{query}%")).limit(10).all()
    return jsonify([{'id': m.id, 'name': m.name, 'contact': m.contact} for m in results])

@app.route("/followup", methods=["GET", "POST"])
@login_required
def followup():
    centers, selected_center_id = get_centers_and_selected()
    if request.method == "POST":
        center_id = int(request.form.get("center_id", selected_center_id))
        name = request.form.get("name")
        contact = request.form.get("contact", "").strip()
        residence = request.form.get("residence")
        first_time = request.form.get("first_time")
        service_number = request.form.get("service_number")
        service_date = request.form.get("service_date")
        outreach_date = request.form.get("outreach_date")
        source = request.form.get("source")

        if len(contact) != 10 or not contact.isdigit():
            flash("Contact must be exactly 10 digits.", "danger")
        elif not name or not source:
            flash("Name and source type are required.", "danger")
        else:
            soul = Soul(
                name=name,
                contact=contact,
                residence=residence,
                first_time=first_time,
                source=source,
                center_id=center_id
            )

            if source == "Service":
                if service_number and service_date:
                    soul.service_number = int(service_number)
                    soul.service_date = datetime.strptime(service_date, "%Y-%m-%d").date()
                else:
                    flash("Service number and date are required for service entries.", "danger")
                    return redirect(url_for("followup"))
            elif source == "Outreach":
                if outreach_date:
                    soul.outreach_date = datetime.strptime(outreach_date, "%Y-%m-%d").date()
                else:
                    flash("Outreach date is required.", "danger")
                    return redirect(url_for("followup"))

            db.session.add(soul)
            db.session.commit()
            flash("Soul registered successfully!", "success")
            return redirect(url_for("followup", center_id=center_id))

    return render_template("followup.html", centers=centers, selected_center_id=selected_center_id)

@app.route('/view_souls')
def view_souls():
    centers, selected_center_id = get_centers_and_selected()
    souls = Soul.query.order_by(Soul.service_date.desc()).all()
    total_souls = Soul.query.count()
    return render_template('view_souls.html', souls=souls, total_souls=total_souls,
                           centers=centers, selected_center_id=selected_center_id)

@app.route('/database')
def database():
    centers = Center.query.all()
    query = Member.query
    search_term = request.args.get('q')

    if search_term:
        search = f"%{search_term}%"
        query = query.filter(
            or_(
                Member.name.ilike(search),
                Member.gender.ilike(search),
                Member.contact.ilike(search),
                Member.residence.ilike(search),
                Member.course_Profession.ilike(search),
                Member.year_of_study.ilike(search),
                Member.home_district.ilike(search),
                Member.marital_status.ilike(search),
                Member.first_time.ilike(search),
                Center.name.ilike(search)  # joining needed for this
            )
        ).join(Center, isouter=True)

    members = query.all()
    return render_template('database.html', members=members, centers=centers)
from sqlalchemy import or_

import csv
from flask import Response

@app.route('/export_csv')
def export_csv():
    query = Member.query.join(Center, isouter=True)
    search_term = request.args.get('q')

    if search_term:
        search = f"%{search_term}%"
        query = query.filter(
            or_(
                Member.name.ilike(search),
                Member.gender.ilike(search),
                Member.contact.ilike(search),
                Member.residence.ilike(search),
                Member.course_Profession.ilike(search),
                Member.year_of_study.ilike(search),
                Member.home_district.ilike(search),
                Member.marital_status.ilike(search),
                Member.first_time.ilike(search),
                Center.name.ilike(search)
            )
        )

    members = query.all()

    def generate_csv():
        data = io.StringIO()
        writer = csv.writer(data)
        writer.writerow(['Name', 'Gender', 'Contact', 'Residence', 'Course/Profession',
                         'Year of Study', 'Home District', 'Marital Status', 'First Time', 'Center'])

        for m in members:
            writer.writerow([
                m.name,
                m.gender or '',
                m.contact or '',
                m.residence or '',
                m.course_Profession or '',
                m.year_of_study or '',
                m.home_district or '',
                m.marital_status or '',
                m.first_time or '',
                m.center.name if m.center else ''
            ])

        return data.getvalue()

    csv_data = generate_csv()

    return Response(
        csv_data,
        mimetype='text/csv',
        headers={"Content-Disposition": "attachment;filename=members.csv"}
    )

@app.route('/edit_member/<int:member_id>', methods=['GET'])
def edit_member(member_id):
    member = Member.query.get_or_404(member_id)
    centers = Center.query.all()
    return render_template('edit_member.html', member=member, centers=centers)

@app.route('/update_member/<int:member_id>', methods=['POST'])
def update_member(member_id):
    member = Member.query.get_or_404(member_id)

    member.name = request.form['name']
    member.gender = request.form['gender']
    member.contact = request.form['contact']
    member.residence = request.form['residence']
    member.course_Profession = request.form['course_Profession']
    member.year_of_study = request.form['year_of_study']
    member.home_district = request.form['home_district']
    member.marital_status = request.form['marital_status']
    member.first_time = request.form['first_time']
    member.center_id = request.form['center_id']

    db.session.commit()
    flash('Member updated successfully!')
    return redirect(url_for('database'))






@app.route('/report/<int:member_id>')
def member_report(member_id):
    member = Member.query.get_or_404(member_id)
    attended_services = {a.service_number for a in member.attendances}

    # Let's say Phaneroo 530 to 540 are in your system
    all_services = [str(i) for i in range(530, 541)]

    missed_services = [s for s in all_services if s not in attended_services]

    return render_template('report.html', member=member,
                           attended_services=attended_services,
                           missed_services=missed_services)

@app.route('/sms', methods=['GET', 'POST'])
def sms():
    centers = Center.query.all()
    recipients = []

    if request.method == 'POST':
        recipient_group = request.form.get('recipient')
        center_id = request.form.get('center_id')
        message = request.form.get('message')

        query = Member.query

        if center_id:
            query = query.filter(Member.center_id == int(center_id))

        if recipient_group == 'souls':
            query = query.filter(Member.is_soul == True)
        elif recipient_group == 'first_timers':
            query = query.filter(Member.first_time.ilike('Yes'))
        elif recipient_group == 'individuals':
            pass  # no extra filter

        recipients = query.all()

        # TODO: Connect to SMS service and send `message` to each member.contact
        flash(f'{len(recipients)} recipients matched. (SMS not yet sent)', 'info')

    return render_template('sms.html', centers=centers, recipients=recipients)


@app.route('/logout')
def logout():
    session.pop('authenticated', None)
    flash('You have been logged out.', 'info')
    return redirect(url_for('home'))






# ------------------- MAIN -------------------

if __name__ == '__main__':
   with app.app_context():
        db.create_all()
   app.run(debug=True)
