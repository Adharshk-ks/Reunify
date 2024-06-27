from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity
from flask_migrate import Migrate
import os

app = Flask(__name__)

app.config['SECRET_KEY'] = '1d6e7266b36003bfef907cd0f7b4b742'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///site.db'
app.config['JWT_SECRET_KEY'] = 'o3bgfZdQVkglrvHfm3ej-87GwxbQlrnEvS2h1FMK_q0'
app.config['UPLOAD_FOLDER'] = 'uploads'

db = SQLAlchemy(app)
migrate = Migrate(app, db)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    password = db.Column(db.String(60), nullable=False)
    reports = db.relationship('Report', backref='author', lazy=True)
    lost_items = db.relationship('LostItem', backref='author', lazy=True)

    def __repr__(self):
        return f"User('{self.username}', '{self.email}')"

class Report(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    image = db.Column(db.String(120), nullable=False)
    description = db.Column(db.String(120), nullable=False)
    location = db.Column(db.String(120), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)

    def __repr__(self):
        return f"Report('{self.description}', '{self.location}')"

class LostItem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    image = db.Column(db.String(120), nullable=False)
    description = db.Column(db.String(120), nullable=False)
    location = db.Column(db.String(120), nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)

    def __repr__(self):
        return f"LostItem('{self.description}', '{self.location}')"

@app.route('/api/signup', methods=['POST'])
def signup():
    data = request.get_json()
    hashed_password = bcrypt.generate_password_hash(data['password']).decode('utf-8')
    user = User(username=data['username'], email=data['email'], password=hashed_password)
    db.session.add(user)
    db.session.commit()
    return jsonify(message="User created successfully"), 201

@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    user = User.query.filter_by(email=data['email']).first()
    if user and bcrypt.check_password_hash(user.password, data['password']):
        access_token = create_access_token(identity={'username': user.username, 'email': user.email})
        return jsonify(access_token=access_token), 200
    return jsonify(message="Invalid credentials"), 401

@app.route('/api/report', methods=['POST'])
@jwt_required()
def report():
    if 'image' not in request.files:
        return jsonify(message="No image file"), 400

    image = request.files['image']
    if image.filename == '':
        return jsonify(message="No selected file"), 400

    if image:
        filename = os.path.join(app.config['UPLOAD_FOLDER'], image.filename)
        image.save(filename)

        data = request.form
        description = data['description']
        location = data['location']
        current_user = get_jwt_identity()
        user = User.query.filter_by(email=current_user['email']).first()

        report = Report(image=filename, description=description, location=location, user_id=user.id)
        db.session.add(report)
        db.session.commit()

        return jsonify(message="Report created successfully"), 201

@app.route('/api/report_lost_item', methods=['POST'])
@jwt_required()
def report_lost_item():
    if 'image' not in request.files:
        return jsonify(message="No image file"), 400

    image = request.files['image']
    if image.filename == '':
        return jsonify(message="No selected file"), 400

    if image:
        filename = os.path.join(app.config['UPLOAD_FOLDER'], image.filename)
        image.save(filename)

        data = request.form
        description = data['description']
        location = data['location']
        current_user = get_jwt_identity()
        user = User.query.filter_by(email=current_user['email']).first()

        lost_item = LostItem(image=filename, description=description, location=location, user_id=user.id)
        db.session.add(lost_item)
        db.session.commit()

        return jsonify(message="Lost item report created successfully"), 201

@app.route('/api/history', methods=['GET'])
@jwt_required()
def history():
    current_user = get_jwt_identity()
    user = User.query.filter_by(email=current_user['email']).first()

    if not user:
        return jsonify(message="User not found"), 404

    reports = Report.query.filter_by(user_id=user.id).all()
    lost_items = LostItem.query.filter_by(user_id=user.id).all()
    report_history = [{
        'image': report.image,
        'description': report.description,
        'location': report.location
    } for report in reports]

    lost_item_history = [{
        'image': item.image,
        'description': item.description,
        'location': item.location
    } for item in lost_items]

    return jsonify(report_history=report_history, lost_item_history=lost_item_history), 200

@app.route('/api/profile', methods=['GET', 'PUT'])
@jwt_required()
def profile():
    current_user = get_jwt_identity()
    user = User.query.filter_by(email=current_user['email']).first()

    if not user:
        return jsonify(message="User not found"), 404

    if request.method == 'GET':
        reports = Report.query.filter_by(user_id=user.id).all()
        lost_items = LostItem.query.filter_by(user_id=user.id).all()
        report_history = [{
            'image': report.image,
            'description': report.description,
            'location': report.location
        } for report in reports]

        lost_item_history = [{
            'image': item.image,
            'description': item.description,
            'location': item.location
        } for item in lost_items]

        return jsonify(username=user.username, email=user.email, report_history=report_history, lost_item_history=lost_item_history), 200

    if request.method == 'PUT':
        data = request.get_json()
        if 'username' in data:
            user.username = data['username']
        if 'email' in data:
            user.email = data['email']
        if 'password' in data:
            hashed_password = bcrypt.generate_password_hash(data['password']).decode('utf-8')
            user.password = hashed_password
        db.session.commit()
        return jsonify(message="Profile updated successfully"), 200

@app.route('/api/protected', methods=['GET'])
@jwt_required()
def protected():
    current_user = get_jwt_identity()
    return jsonify(logged_in_as=current_user), 200

@app.route('/api/homepage', methods=['GET'])
def homepage():
    return jsonify(message="Welcome to the Lost and Found API!",
                   description="You can use this API to report lost items, view your report history, and more. Sign up and log in to get started.",
                   endpoints={
                       "signup": "/api/signup",
                       "login": "/api/login",
                       "report": "/api/report",
                       "report_lost_item": "/api/report_lost_item",
                       "history": "/api/history",
                       "profile": "/api/profile",
                       "protected": "/api/protected"
                   }), 200

if __name__ == '__main__':
    if not os.path.exists(app.config['UPLOAD_FOLDER']):
        os.makedirs(app.config['UPLOAD_FOLDER'])
    with app.app_context():
        db.create_all()
    app.run(debug=True)
