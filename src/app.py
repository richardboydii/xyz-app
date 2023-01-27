# import the Flask class from the flask module
from flask import Flask, jsonify, render_template

# create the application object
app = Flask(__name__)

# use decorators to link the function to a url
@app.route('/')
def home():
    return render_template('index.html') # render the index page

@app.route('/magic')
def magic():
    return "DevOps" # return the magic word

@app.route('/json')
def magic_json():
    return jsonify({'DevOps': 'magic'}) # return the magic word in JSON

# start the server with the 'run()' method
if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
