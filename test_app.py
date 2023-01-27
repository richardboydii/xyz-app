from app import app
import json

def test_index():
    response = app.test_client().get('/')

    assert response.status_code == 200
    assert b'Welcome to the Demo App' in response.data

def test_magic():
    response = app.test_client().get('/magic')

    assert response.status_code == 200
    assert response.data == b'DevOps'

def test_json():
    response = app.test_client().get('/json')

    assert response.status_code == 200
    expected = {'DevOps': 'magic'}
    assert expected == json.loads(response.get_data(as_text=True))