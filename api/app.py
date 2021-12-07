from flask import Flask, request, jsonify
from PIL import Image
from tensorflow import keras
from keras.layers import Input, Dense, Activation, BatchNormalization, Flatten, Conv2D, MaxPool2D, LSTM, Embedding, SimpleRNN, Reshape, Lambda
import numpy as np
import cv2
from skimage.filters import threshold_otsu
from skimage.color import rgb2gray, convert_colorspace, rgb2gray, rgb2gray
from skimage import io, filters

app = Flask(__name__)
model_cnn = keras.models.load_model('./model_cnn.h5')
model_rnn = keras.models.load_model('./model_rnn.h5', custom_objects={
    "Reshape": Reshape,
    "Lambda": Lambda,
    "Flatten": Flatten,
    "SimpleRNN": SimpleRNN,
    "Conv2D": Conv2D

})
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

#flask run -h 192.168.0.118

@app.route("/classificar", methods=["POST"])
def process_image():
    print('Realizando classificação...')
    img = request.files['file']
    img.save("img-original.jpg")
    SIZE = 28

    img = cv2.imread("img-original.jpg", 0)
    img_gray = rgb2gray(img)
    thresh = threshold_otsu(img_gray)
    binary_thresh_img = img_gray > thresh
    io.imsave("img-tratada.png", binary_thresh_img)

    with Image.open("img-tratada.png") as im:
        imagem = im.resize((SIZE,SIZE)).convert('L')
        imagem = np.array(imagem)/255
        result_cnn = model_cnn.predict(np.array([imagem]))[0]
        result_rnn = model_rnn.predict(np.array([imagem]))[0]
        r = {'cnn': result_cnn.tolist(), 'rnn': result_rnn.tolist()}
    return jsonify(r)


if __name__ == "__main__":
    app.run(debug=True)