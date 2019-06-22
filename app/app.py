from flask import Flask, Response
import json

app = Flask(__name__)

# endpoint with hello message
@app.route('/')
def hello():
	return Response(
		json.dumps(
			{
				'message': 'hello'
			}, 
			sort_keys=True, 
			indent=4,
		),
		mimetype='application/json',
		status=200)


# endpoint with healthcheck
@app.route('/health')
def health():
	return Response(
		json.dumps(
			{
				'message': 'healthy'
			}, 
			sort_keys=True, 
			indent=4,
		),
		mimetype='application/json',
		status=200)

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
