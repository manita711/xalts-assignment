
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health_check():
    response = {
        'result': 'Healthy',
        'error': False
    }
    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True,host="0.0.0.0", port=5000)

