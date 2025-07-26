from extensions import db
from datetime import date

class Center(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)

    attendees = db.relationship('Attendee', backref='center', lazy=True)
    souls = db.relationship('Soul', backref='center', lazy=True)
    services = db.relationship('PhanerooService', backref='center', lazy=True)

class PhanerooService(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    number = db.Column(db.Integer, unique=True, nullable=False)
    service_date = db.Column(db.Date, nullable=False, default=date.today)
    center_id = db.Column(db.Integer, db.ForeignKey('center.id'), nullable=False) 
    attendees = db.relationship('AttendanceRecord', backref='service', lazy=True)

class Attendee(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    contact = db.Column(db.String(10), nullable=False)
    residence = db.Column(db.String(100), nullable=False)
    course_Profession = db.Column(db.String(100), nullable=False)
    first_time = db.Column(db.Boolean, nullable=False)
    center_id = db.Column(db.Integer, db.ForeignKey('center.id'), nullable=False) 
    attendance_records = db.relationship('AttendanceRecord', backref='attendee', lazy=True)
    year_of_study = db.Column(db.String(20))
    
class AttendanceRecord(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    attendee_id = db.Column(db.Integer, db.ForeignKey('attendee.id'), nullable=False)
    service_id = db.Column(db.Integer, db.ForeignKey('phaneroo_service.id'), nullable=False)
    first_time_status = db.Column(db.String(10), default='No')
   

    def __repr__(self):
        return f"<AttendanceRecord AttendeeID={self.attendee_id} ServiceID={self.service_id} FirstTime={self.first_time_status}>"

class Soul(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    contact = db.Column(db.String(10), nullable=False)
    residence = db.Column(db.String(100), nullable=False)
    first_time = db.Column(db.String(10), nullable=True)  # 'Yes' or 'No'
    service_number = db.Column(db.Integer, nullable=True)
    service_date = db.Column(db.Date, default=date.today, nullable=True)
    outreach_date = db.Column(db.Date, nullable=True)
    source = db.Column(db.String(20))
    center_id = db.Column(db.Integer, db.ForeignKey('center.id'), nullable=False) 
