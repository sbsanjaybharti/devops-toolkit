from flask import Flask, render_template, request, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Database Config
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db' # SQLite
# app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://user:password@localhost/dbname' # PostgreSQL
# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://user:password@localhost/dbname' # MSQL

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Model define
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)

    def as_dict(self):
        return {
            'id': self.id,
            'username': self.username,
            'email': self.email
        }

# Create Database
with app.app_context():
    db.create_all()


# Router
@app.route('/create', methods=['POST'])
def create():
    data = request.json
    try:
        user = User(
            username=data['username'],
            email=data['email']
        )
        db.session.add(user)
        db.session.commit()
        return jsonify(user.as_dict()), 200
    except KeyError as e:
        return jsonify({'error': f'Missing required field: {e}'}), 400

@app.route("/update/<int:user_id>", methods=['PUT'])
def update(user_id):
    try:
        user = User.query.get_or_404(user_id)
        return jsonify(user.as_dict())
    except Exception as e:
        return jsonify({'error': f'Error updating user: {e}'}), 500

@app.route('/list')
def list_users():
    users = User.query.all()
    return jsonify([user.as_dict() for user in users])

@app.route('/<int:user_id>')
def get_user(user_id):
    user = User.query.get_or_404(user_id)
    return jsonify(user.as_dict())

@app.route('/')
def home():
    return "Hello World!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)