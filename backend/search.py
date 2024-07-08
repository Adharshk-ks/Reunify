from flask import Flask, request, jsonify
import numpy as np
from tensorflow.keras.applications import VGG16
from tensorflow.keras.preprocessing import image
from tensorflow.keras.applications.vgg16 import preprocess_input
import base64
from PIL import Image
from io import BytesIO
from firebase_admin import credentials, firestore, initialize_app
import requests  # Import requests library to download images
import re  # Import regex for query matching

app = Flask(__name__)

# Initialize Firebase Admin SDK (replace with your Firebase service account credentials)
cred = credentials.Certificate(r'E:\V2\reunify\backend\reunify-3eef3-firebase-adminsdk-v6f5f-309e38c282.json')
default_app = initialize_app(cred)
db = firestore.client()

# Load pre-trained VGG16 model
vgg_model = VGG16(weights='imagenet', include_top=False, input_shape=(224, 224, 3))

def preprocess_image(base64_image):
    try:
        image = Image.open(BytesIO(base64.b64decode(base64_image)))
        image = image.resize((224, 224))  # Resize image to match VGG16 input size
        image = np.array(image)
        image = preprocess_input(image)
        image = np.expand_dims(image, axis=0)
        print("Image preprocessed successfully.")
        return image
    except Exception as e:
        print(f"Error preprocessing image: {e}")
        return None

def preprocess_url_image(url):
    try:
        response = requests.get(url)
        img = Image.open(BytesIO(response.content))
        img = img.resize((224, 224))  # Resize image to match VGG16 input size
        img_array = np.array(img)
        img_array = preprocess_input(img_array)
        img_array = np.expand_dims(img_array, axis=0)
        print("Image from URL preprocessed successfully.")
        return img_array
    except Exception as e:
        print(f"Error preprocessing image from URL: {e}")
        return None

def extract_vgg16_features(image):
    try:
        features = vgg_model.predict(image)
        features = features.flatten()  # Flatten features to 1D array
        print("VGG16 features extracted successfully.")
        return features
    except Exception as e:
        print(f"Error extracting VGG16 features: {e}")
        return None

def calculate_similarity(input_features, dataset_features):
    try:
        if len(dataset_features) == 0:
            return []

        # Calculate cosine similarity between input and dataset features
        similarities = np.dot(input_features, dataset_features.T)
        similarities = similarities / (np.linalg.norm(input_features) * np.linalg.norm(dataset_features, axis=1))
        return similarities
    except Exception as e:
        print(f"Error calculating similarity: {e}")
        return []

@app.route('/search', methods=['POST'])
def search():
    try:
        data = request.get_json()
        query = data.get('query')
        base64_image = data.get('image')

        print(f"Received query: {query}")

        if base64_image:
            input_image = preprocess_image(base64_image)
        else:
            image_url = data.get('imageUrl')
            if image_url:
                input_image = preprocess_url_image(image_url)
            else:
                return jsonify({'error': 'No image or image URL provided.'}), 400

        if input_image is None:
            return jsonify({'error': 'Failed to preprocess image or image URL.'}), 400

        # Extract features from input image if available
        input_features = extract_vgg16_features(input_image)

        # Retrieve dataset features and paths from Firebase Firestore
        dataset_features = []
        dataset_urls = []
        dataset_descriptions = []
        dataset_names = []
        dataset_locations = []
        dataset_contacts = []
        dataset_is_listed = []
        dataset_time = []  # Added dataset_time for time information

        # Fetch dataset paths, descriptions, names, locations, and contacts from Firestore
        posts_ref = db.collection('posts')
        docs = posts_ref.stream()

        for doc in docs:
            post_data = doc.to_dict()
            if 'imageUrl' in post_data:
                dataset_urls.append(post_data['imageUrl'])  # Assuming imageUrl stores Firebase Storage URLs
                dataset_descriptions.append(post_data.get('description', ''))
                dataset_names.append(post_data.get('name', ''))
                dataset_locations.append(post_data.get('location', ''))
                dataset_contacts.append(post_data.get('contact', ''))
                dataset_is_listed.append(post_data.get('isListing',''))  # Fixed isListed default value
                dataset_time.append(post_data.get('time', ''))  # Added time field

        # Extract features for all dataset images
        for url in dataset_urls:
            try:
                response = requests.get(url)
                img = Image.open(BytesIO(response.content))
                img = img.resize((224, 224))  # Resize image to match VGG16 input size
                img_array = np.array(img)
                img_array = preprocess_input(img_array)
                img_array = np.expand_dims(img_array, axis=0)
                features = vgg_model.predict(img_array)
                features = features.flatten()
                dataset_features.append(features)
            except Exception as e:
                print(f"Error processing image from URL {url}: {e}")

        dataset_features = np.array(dataset_features)

        print(f"Loaded {len(dataset_urls)} dataset images and extracted features.")

        # Calculate similarity scores
        similarities = calculate_similarity(input_features, dataset_features)
        print("Similarity scores:", similarities)

        # Filter results by query matching description or name and add isListed status
        filtered_images = []
        for i, url in enumerate(dataset_urls):
            if (query and (re.search(query.lower(), dataset_descriptions[i].lower()) or re.search(query.lower(), dataset_names[i].lower()))) or (similarities[i] > 0.5):
                filtered_images.append({
                    'imageUrl': url,
                    'similarity_score': float(similarities[i]) if similarities.size > 0 else None,
                    'name': dataset_names[i],
                    'location': dataset_locations[i],
                    'contact': dataset_contacts[i],
                    'isListed': dataset_is_listed[i],
                    'time': dataset_time[i],  # Add time information
                })

        return jsonify(filtered_images)

    except Exception as e:
        print(f"Error during search request: {e}")
        return jsonify({'error': 'Internal server error'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
