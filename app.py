from flask_socketio import SocketIO
from flask import Flask,flash,request,redirect,url_for,send_from_directory,send_file,jsonify


app = Flask(__name__)
socketio = SocketIO(app)

@app.route("/emit")
def emitExample():
    socketio.emit('syncPosition', {
      'success': True,
      'message': 'Got file'
    })
    return "Emitted"

@socketio.on('syncPosition')
def handle_message(data):
    emitPostion(data)

def emitPostion(data):
    print(data)
    socketio.emit('syncPosition', data)
    
# Main
if __name__ == '__main__':
    socketio.run(app, host='0.0.0.0', port=5500, debug=True,use_reloader=True)