from flask import Flask, request, jsonify
from PIL import Image
from tensorflow import keras
import numpy as np

app = Flask(__name__)
model = keras.models.load_model('./my_model.h5')
images_labels = ['bee',
  'coffee cup',
  'guitar',
  'hamburger',
  'rabbit',
  'truck',
  'umbrella',
  'crab',
  'banana',
  'airplane']

@app.route("/classificar", methods=["POST"])
def process_image():
    img = request.files['file']
    img.save("img.jpg")
    SIZE = 28
    with Image.open("img.jpg") as im:
        imagem = im.resize((SIZE,SIZE)).convert('L')
        imagem = np.array(imagem)/255
        print(imagem.shape)
        result = model.predict(np.array([imagem]))[0]
        id_max = 0
        val_max = 0
        for i, v in enumerate(result):
            if v > val_max:
                id_max = i
                val_max = v

        print(images_labels[id_max])
    return jsonify({'msg': images_labels[id_max]})


if __name__ == "__main__":
    app.run(debug=True)