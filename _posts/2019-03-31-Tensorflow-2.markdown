---
layout: post
categories: Deep-Learning
tags: [deep-learning, neural-networks, Tensorflow]

---

# A simple example of tensorflow

## Build the model

The basic building block of a neural network is the **layer**, which extract representations from the data fed into them.
These representations are more meaningful for the problem at hand. To build a neural network, we need to configure the layers
of the model first, and then build the model. Most of deep learning consistens of simple layers that are chaining together, 
and most of the layers have parameters that are learnt during training.

```python
import tensorflow.keras as keras

model = keras.Sequential([
    keras.layers.Flatten(input_shape=(28, 28)),
    keras.layers.Dense(128, activation='relu'),
    keras.layers.Dense(10, activation='softmax')
])
```

For example, this neural network model consits of three layers, one **keras.layers.Flatten** layer and two **keras.layers.Dense** layer. 
The **keras.layers.Flatten** layer transforms the format of the images from a 2d-array to a 1d-array. This layer has no parameters to 
learn; it only reformats the data. The **keras.layers.Dense** layers are densely-connected (fully-connected), neural layers. The first
layer has 128 neurons with the **relu** activation function. The last layer has 10 neurons with the **softmax** activation function. 
It returns an array of 10 probability scores that sum to 1. Each node contains a score that indicates the probability that the current 
image belongs to one of the 10 classes.

## Compile the model

After building the model, we need to compile it with the specified configurations:

- Loss function : This measures how accurate the model is during training. We want to minimize this function to "steer" the model in the 
  right direction.
- Optimizer : This is how the model is updated based on the data it sees and its loss function.
- Metrics : Used to monitor the training and testing steps. The following example uses **accuracy**, the fraction of the images that are 
  correctly classified.

```python
model.compile(optimizer='adam', 
              loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])
```

## Train the model

After compiled the model, we can train it with the training datasets. It learns to associate inputs with labels. We run the training for
5 epochs.

```python
model.fit(train_images, train_labels, epochs=5)
```

## Evaluate accuracy

After we trained the neural network, we can use test dataset to evaluate the accuracy and see how the model performs on test dataset.


```python
test_loss, test_acc = model.evaluate(test_images, test_labels)
print('\nTest accuracy:', test_acc)
```

If the test accuracy is smaller than the training accuracy, we say it has an **overfitting**. Overfitting is when a machine learning 
model performs worse on new data than on their training data.

## Make predictions

With the model trained, we can use it to make predictions about some images.

```python
predictions = model.predict(test_images)
np.argmax(predictions[0])
```

In this example, a prediction is an array of 10 numbers. These describe the "confidence" of the model that the image corresponds to each 
of the 10 different articles of clothing. We can see which label has the highest confidence value.
