from flask import Flask,jsonify
import psutil
app = Flask(__name__)

cpu_percentage = psutil.cpu_percent()
memory_percentage = psutil.virtual_memory()[2]
disk_percentage = psutil.disk_usage('/')[3]




@app.route("/")
def hello():
    return jsonify(
        {
            "CPU Utilisation" : cpu_percentage,
            "RAM Utilisation" : memory_percentage,
            "Disk Utilisation" : disk_percentage
        }
    )

if __name__ == "__main__":
    app.run(host='0.0.0.0')