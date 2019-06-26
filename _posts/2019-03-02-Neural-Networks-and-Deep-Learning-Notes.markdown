---
layout: post
categories: Deep-Learning
tags: [deep-learning, neural-networks]

---


# How does machine learn with neural networks?

Neural networks as well as other machine learning algorithms **use a set of training examples
to automatically infer rules for the predefined learning problem**, such as digits recognition.
We can see the rules a function $$y = f(x)$$ that maps each example, represented as a vector `x`, to
the output `y`. The more general training examples we use, the more accurate the algorithm will be.
That's why data is very important for machine learning.

## What is Neural Network?

To understand what is Neural Network, we need to understand artificial neuron, which is the basic
component of a Neural Network. A well-known model of artificial neural is **perceptron**, which was
proposed by Frank Rosenblatt in 1950s and 1960s. 

A perceptron takes several binary inputs $$x_1$$, $$x_2$$, ..., and produces a single binary output.
We use weights to represent the importance of each input to the output. The output of the perceptron (0 or 1)
is determined by whether the **weighted sum of inputs** ($$\sum_{j} w_j x_j$$) is greater than or less 
than some **threshold value** (a real number). For example, the following perceptron has three inputs, each input
has a weight.

![Perceptron](/assets/images/perceptron.png)

The algebraic representation of the perceptron is:

$$
output =
\begin{cases}
0  & \text{if $\sum_{j} w_j x_j$ $\le$ threshold} \\
1  & \text{if $\sum_{j} w_j x_j$ $\gt$ threshold}
\end{cases}
$$

We can see the perceptron as a device of decision making, by varying the weights and the threshold, we can get
different models of decision making. If we connect perceptrons as a network, then it can make quite sutle decisions.

![Neural Network](/assets/images/neural-network.png)

In this example, the 3 perceptrons in the first layer make three very simple decisions by weighting the input
evidence. The 4 perceptrons in the second layer (we call it hidden layer) can make more complex and more abstract decisions with
the output of the first layer as inputs. Finally, the third layer (output layer) can make more complex decisions. We can further 
simplify the previous equations with two changes:

1. use dot product to represent the weighted sum, $$w \bullet x \equiv \sum_{j} w_j x_j $$
1. use perceptron's bias instead of threshold, $$ b \equiv -threshold$$

Bias ($$b$$) represents how easy it is to get the perceptron to output 1 or to fire. Then, we can get the simplified function as this.

$$
output =
\begin{cases}
0  & \text{if $w \bullet x + b \le 0$} \\
1  & \text{if $w \bullet x + b \gt 0$}
\end{cases}
$$

Through adjusting the weights and bias of a perceptron, we can use it to represent a NAND gate. Thus, we can use neural networks to
represent digital circuits. Different with digital circuits, we can write learning algorithms to dynamically adjust the weights and
biases of a neural network, that's how neural network learns. We give the neural network a group of training sets, changing the weights
and biases over and over to produce better output. Then, the network would learn.

## Sigmoid neurons

To make the network learn, **a minimal change of inputs should only cause a minimal change of output**. Otherwise, we do not know how to
change weights and biases to get better output. The problem with perceptron neural model is that a tiny change in the input may completely
flip the output (either 0 or 1). Then the following perceptrons' output may completely change in some very complicated way. Thus the network 
composed by perceptrons can hardly learn. (Maybe there is a clever way, but it is obvious now how a network of perceptrons to lear.)

**Sigmoid neurons** was introduced to overcome this issue. The inputs of sigmoid neuron can take any values between 0 and 1, and the output
of sigmoid neuron is $$\sigma (w \bullet x + b) $$ ($$\sigma$$ is called the **sigmoid function**) and is defined by:

$$
\sigma (z) \equiv \frac{1}{1 + e^{-z}}   \\   z = w \bullet x + b
$$

If the weighted sum ($$z$$) is a larger positive number, then $$e^{-z} \approx 0$$ and so $$\sigma (z) \approx 1$$. On the other hand,
if $$z$$ is very negative, then $$e^{-z} \approx - \infty$$ and so $$\sigma (z) \approx 0$$. So a sigmoid neuron is closely approximates
a perceptron except when $$z$$ is of modest size. Here is the shape of the sigmoid function. We can see it is a smoothed out version of a 
step function.

![Sigmoid function](/assets/images/sigmoid-fun-shape.png)

The smoothness of $$\sigma$$ means that a small changes in $$\Delta w_j$$ in the weights and $$\Delta b$$ in the bias will produce a small
change $$\Delta output$$ in the output from the neuron. Based on what we learn from calculus, we know that:

$$
\Delta output \approx \sum_{j}\frac{\partial output}{\partial w_j} \Delta w_j + \frac{\partial output}{\partial b}\Delta b
$$

We see that $$\Delta output$$ is a linear function of $$\Delta w_j$$ and $$\Delta b$$ in each weights and bias. So that, it is easy to make small
changes in weights and bias so as to achieve any desired change in the output. In fact, it is the shape of $$\sigma$$ function really matters,
some other functions of similar shape were also used as the **activation function** of neural networks.

## The architecture of Neural Networks

Usually a neural network has 3 or more layers; the leftmost layer is input layer and the rightmost layer is output layer, layers between these
two layers are called hidden layers. The output of previous layer is used as the input of the next layer; this kind of neural network are called
feedforward neural networks. The input layer and output layers are usually straightforward, however there are no simple rules about how to design 
the hidden layers. We usually use some heuristics to trade off different designs and get the behaviour we want out of our nets.

## How does machine learn with nerural networks?
Now we are ready to answer this question. After we designed the architecture of the neural networks, we know that each neuron $$N_{i,j}$$ 
(the $$j$$th neuron of the $$i$$th layer) of the network (except input neurons) has a group of parameters $$w_{i,j}^1, w_{i,j}^2, ..., b_{i,j}$$.
Our goal is using a group of training examples to train the neural network so as to find the suitable values for these parameters. With this values,
the neural network can accurately map general inputs to the outputs. We usually use a cost function to evaluate the accuracy of the neural network.
A commonly used cost function is the quadratic cost function (or mean square error, MSE):
(**We do not use the number or percentage of correct classification because it is not a smooth function. A small change in weights and biases
may not cause any change of the number of success classifications.** )
$$
C(w, b) \equiv \frac {1}{2n} \sum_{x} ||y(x) - a||^2
$$

- $$w$$: all the weights of the neural network
- $$b$$: all the biases of the neural network
- $$n$$: the number of training inputs
- $$a$$: the output of the network when x is input
- $$y(x)$$: the expected output of the input x

Simplify speaking, we need to find out the suitable values for weights and biases of neurons to minimize the value of the cost function $$C(w, b)$$.
The training of neural networks becomes a minimization problem in math now. In math, we use the **gradient descent** algorithm to solve this kind
of problems.

### Gradient Descent
It is easy to find out the extremum of functions with 1 or 2 variables, but neural networks usually has many more weights and biases. Using calculus
to calculate the extremum won't work. The idea of gradient descent algorithm is that we randomly choose a point in the multi-dimension space, then
we move it a little bit towards the direction that $$C(w, b)$$ would decrease. Assume the cost function only has two variables $$v_1$$ and $$v_2$$.
If we change $$\Delta v_1$$ in $$v_1$$ direction and $$\Delta v_2$$ in $$v_2$$ direction, then we have:

$$
\Delta C \approx \frac{\partial C}{\partial v_1} \Delta v_1 + \frac{\partial C}{\partial v_2} \Delta v_2
$$

We denote $$\Delta v$$ to be the vector of changes and $$\nabla C$$ to be the vector of partial derivatives.

$$
\Delta v \equiv (\Delta v_1 , \Delta v_2)^T \\
\nabla C \equiv (\frac{\partial C}{\partial v_1}, \frac{\partial C}{\partial v_2})^T
$$ 

Thus, we have:

$$
\Delta C \approx \nabla C . \Delta v
$$

If we choose 

$$
\Delta v = - \eta \nabla C
$$

then we have

$$
\Delta C \approx - \eta ||\nabla C||^2
$$

Which is less than 0. $$\eta$$ is a small, positive parameter known as the **learning rate**. 
The previous equations tells us that if we always move the point $$v$$ to $$v'$$ such that 

$$
v' = v - \eta \nabla C
$$

If we keep doing this movement over and over again, we will keep decreasing $$C$$ until it reaches
a global minimum.

To sum up, gradient descent algorithm works by randomly picking a point and then we compute the gradient
$$\nabla C$$ of the point. Then we move the point in the opposite directive to a new point and compute the
$$\nabla C$$ of this new point. We repeat these steps again and again until we reach the global minimum. 
This process looks like a ball falling down of the valley, which is visualizable like this:

![Ball falling down](/assets/images/ball-falling.png)

In neural networks, the point $$v$$ is composed by weights $$w$$ and biases $$b$$. So we have

$$
v = [w_1, w_2, ..., w_n, b_1, b_2, ..., b_m]^T \\
v' = [w_1', w_2', ..., w_n', b_1', b_2', ..., b_m']^T \\
\nabla C = [\frac{\partial C}{\partial w_1},
            \frac{\partial C}{\partial w_2},...,
            \frac{\partial C}{\partial w_n},
            \frac{\partial C}{\partial b_1},
            \frac{\partial C}{\partial b_2}...,
            \frac{\partial C}{\partial b_m}]^T
$$

We can update any weight $$w_k$$ and any bias $$b_l$$ with the following equations

$$
w_k' = w_k - \eta \frac{\partial C}{\partial w_k} \\
b_l' = b_l - \eta \frac{\partial C}{\partial b_l}
$$

**This is the rule that neural networks used to learn.**

### Stochastic gradient descent
To use the gradient descent rule, one of the problem we need to solve is that it is very time consuming
to compute $$\nabla C$$. That is because the cost function computes the average mean square error (MSE) of 
all training examples:

$$
C = \frac{1}{n} \sum_{x} C_x \\
C_x \equiv \frac{||y(x) - a||^2}{2}
$$ 

To compute $$\nabla C$$, we need to compute the gradients $$\nabla C_x$$ for each training input $$x$$, and then 
average them

$$
\nabla C = \frac{1}{n} \sum_{x} \nabla C_x
$$

When the training sets is very large, the learning is very slow (updating weights and biases towards the minimum point).
An idea named **stochastic gradient descent** can be used to speed up the learning. It estimate the gradient $$\nabla C$$
by computing $$\nabla C_x$$ for a small set of randomly chosen training inputs. 

In the real case, we usually randomly split the training inputs into k sets: $$X_1, X_2, ..., X_k$$ (refer to them as a mini-batch).
Each mini-batch contains m inputs. m is big enough that we can roughly expect 

$$
\frac{\sum_{j=1}^{m} \nabla C_{X_j}}{m} \approx \frac{\sum_{x} \nabla C_x}{n} = \nabla C
$$

$$X_j$$ represents the $$j$$th input of a mini-batch. Then we can change the updating rules of weights and biases as follows

$$
w_k' = w_k - \frac{\eta}{m} \sum_j \frac{\partial C_{X_j}}{\partial w_k} \\
b_l' = b_l - \frac{\eta}{m} \sum_j \frac{\partial C_{X_j}}{\partial b_l}
$$

After we train with one mini-batch, then we train with another mini-batch. After we exhausted all the training inputs, which is
said to complete an **epoch** of training, we start with a new epoch. Even if the update rule is not very accurate, it guarantees
the point (weights and biases) moves towards a direction that helps to decrease C. 

## Deep Learning

We mentioned that a neural network defines a function $$ f = y(x)$$ that maps inputs to outputs. No matter how complicated the real
mapping is, we can design a neural network with only one hidden layer (find a function $$f$$) such that the cost $$C$$ is less than 
an expected value $$\epsilon$$ ($$\epsilon$$ is a very small positive value). We will see how this works later. The idea is neural
networks with even one hidden layer are very powerful.

Because the input dimension of real learning problems, such as face detection, is usually very large. For example, the input dimension
of face detection problem is the total number of pixels of the image. To design a neural network with one hidden layer for this problem,
the number of neurons must be very very large. Multi-layer neural networks can represent more capabilities with much less neurons. This
design heuristic is also natural. For example, to detect the face in the image, we can split the image into multiple sub-images (part of
the pixels may overlap); then the neurons of the next layer detects whether each sub-image contains an eye (or a nose, or a mouth) or not.
Finally, the output layer uses the outputs of hidden lays to figure out whether a face exists in the image or not.

This example just gives us an idea that we can split the problem into sub-problems and build multiple hidden layers. We can also see each
sub-problem to be solved by a sub-neural network. In the many layer neural network, early layers answering simple and specific questions about
the input, and later layers building up a hierarchy of ever more complex and abstract concepts. We call this kind of network **deep neural
networks**.

# How the backpropogation algorithm works?

We know that we use gradient descent algorithm to learn the weights and biases of neural networks, but how to compute gradients? An algorithm
named **backpropogation** (the workhorse of learning) is used to do this.

## Several notations
To describe how backpropogation algorithm, we need to introduce several notations first.

- $$w_{jk}^{l}$$ : the weight for the connection from the $$k^{th}$$ neuron in the $$(l-1)^{th}$$ layer to the $$j^{th}$$ neuron in the $$l^{th}$$ layer.
- $$b_j^l$$ : the bias of the $$j^{th}$$ neuron in the $$l^{th}$$ layer.
- $$a_j^l$$ : the activation of the $$j^{th}$$ neuron in the $$l^{th}$$ layer.
- $$z_j^l$$ : the weighted input of the $$j^{th}$$ neuron in the $$l^{th}$$ layer.
- $$\delta_j^l$$ : the error in the $$j^{th}$$ neuron in the $$l^{th}$$ layer.

With these notations, we have

$$
a_j^l = \sigma (\sum_k w_{jk}^l a_k^{l-1} + b_j^l)
$$

To rewrite this equation in a matrix form, we define a weight matrix $$w^l$$ for each layer $$l$$. The entries of the weight matrix are just the
weights connecting to the $$l^{th}$$ layer of neurons (the $$j^{th}$$ neuron's weights is the $$j^{th}$$ row of the matrix) , the entry in the 
$$j^{th}$$ row and $$k^{th}$$ column is $$w_{jk}^l$$. Similarly, we define a bias vector $$b^l$$ and an activation matrix $$a^l$$ for the $$l^{th}$$ layer.
We can rewrite the previous equations as follows 

$$
a^l = \sigma (w^l a^{l-1} + b^l)
$$

The $$\sigma$$ function is applied to each element of the vector. We also use $$z^l$$ to rewrite the equations as follows

$$
a^l = \sigma z^l
z^l = w^l a^{l-1} + b^l
$$

## Two assumptions

To use the backpropogation algorithm to calculate $$\frac{\partial C}{\partial w}$$ and $$\frac{\partial C}{\partial b}$$ for each
weight $$w$$ and each bias $$b$$ of the neural network, we need to make two assumptions about the form of the cost function.

1. The first assumption is that the cost function can be written as an average $$C = \frac{1}{n} \sum_x C_x$$ over cost functions $$C_x$$
   for individual training examples x. We need this assumption because backpropogation works by computing the derivatives 
   $$\partial C_x / \partial w$$ and $$\partial C_x / \partial b$$ for each training example and then recover $$\partial C / \partial w$$
   and $$\partial C / \partial b$$ by averaging over all training examples.
1. The second assumption is that the cost can be rewritten as a function of the outputs from the neural network.

The quadratic cost function meets all these two assumptions.


## Four Fundamental equations

Backpropogation tells us how cost function changes with the weights and biases in a network. To compute $$\partial C / \partial w_{jk}^l$$
and $$\partial C / \partial b_j^l$$, we need to compute the error of each layer $$\delta_j^l$$ first. We define $$\delta_j^l$$ as
$$\partial C / \partial z_j^l$$. Why do we define it this way?

For the $$j^{th}$$ neuron in layer l, the weighted input has a little change $$\Delta z_j^l$$, then the output of this neuron becomes
$$\sigma (z_j^l + \Delta z_j^l)$$. This change propogates to the following layers and finally causing the cost to change by an amount
$$\frac{\partial C}{\partial z_j^l} \Delta z_j^l $$.

To make the cost smaller, we can choose $$\Delta z_j^l$$ to have the opposite sign to $$\partial C / \partial z_j^l$$. If $$\partial C / \partial z_j^l$$
is close to zero, then we cannot change cost too much by perturbing the weighted input $$z_j^l$$. So, their is a heuristic sense that
$$\partial C / \partial z_j^l$$ is a measure of the error in the neuron. Thus we define error as

$$
\delta_j^l \equiv \frac{\partial C}{\partial z_j^l}
$$

### Equation 1

$$
\delta_j^L = \frac{\partial C}{\partial a_j^L} \sigma ' (z_j^L)
$$

$$\frac{\partial C}{\partial a_j^L}$$ measures how fast the cost is changing as a function of the $$j^{th}$$ output activation.
If $$C$$ does not dependent much on a particular neuron j, then $$\delta j^L$$ will be small. $$\sigma ' (z_j^L)$$ measures how
fast the activation function $$\sigma$$ is changing at $$z_j^L$$.

If we use the quadratic cost function, then

$$
\frac{\partial C}{\partial a_j^L} = (a_j^L - y_j)
$$

We rewrite the equation in a matrix-based form, as

$$
\delta ^L = \nabla _a C \odot \sigma ' (z^L)
$$

$$\nabla _a C$$ is defined to be a vector whose components are the partial derivatives $$\partial C / \partial a_j^L$$.
In the case of quadratic cost function,

$$
\nabla _a C = (a^L - y)
$$

Thus, we have

$$
\delta ^L = (a^L - y) \odot \sigma ' (z^L)
$$


### Equation 2

$$
\delta ^l = ((w^{l+1})^T \delta ^{l+1}) \odot \sigma ' (z^l)
$$

$$\delta ^{l+1}$$ is the error of the $$(l+1)^{th}$$ layer, when we apply the transpose weight matrix $$(w^{l+1})^T$$, we can
think this as moving the error backward through the network.

With equation 1 and 2, we can compute the error for any layer in the network.

### Equation 3

$$
\frac{\partial C}{\partial b_j^l} = \delta _j^l
$$

The error is exactly equal to the rate of change $$\partial C / \partial b_j^l$$.


### Equation 4

$$
\frac{\partial C}{\partial w_{jk}^l} = a_k^{l-1} \delta _j^l
$$

When $$a_(l-1) \approx 0$$, the gradient term $$\partial C / partial w$$ will also tend to be small. In this case, we say the
weight learns slowly (not changing much during gradient descent). When $$\sigma (z_j^L)$$ is approximately 0 or 1, the $$\sigma$$
function is very flat, we will have $$\sigma ' (z_j^L) \approx 0$$. In this case, a weight in the final layer will learn slowly if the output
neuron is either low activation ($$\approx 0$$) or high activation ($$\approx 1$$), we say the output neuron has **saturated**
(the weight has stopped learning).

**To sum up, a weight will learn slowly if either the input neuron is low-activation, or if the output neuron has saturated.**

## The backpropogation algorithm

1. Input x: set the corresponding activation $$a^1$$ for the input layer.
1. Feedforward: for each $$l = 2, 3, ..., L$$ compute
   $$z^l = w^l a^{l-1} + b^{l}$$ and $$a^l = \sigma(z^l)$$
1. Output error $$\delta ^L$$: compute the vector $$\delta ^L = \nabla _a C \odot \sigma ' (z^L)$$
1. Backpropagate the error: for each $$l = L-1,...,2$$ compute $$\delta ^l = ((w^{l+1})^T \delta ^{l+1}) \odot \sigma ' (z^l)
1. Output: the gradient of the cost function is given by $$\frac{\partial C}{\partial w_{jk}^l} = a_k^{l-1} \delta _j^l$$ and
   $$\frac{\partial C}{\partial b_j^l} = \delta _j^l$$.
   
# Improving the way neural networks learn

The backpropogation algorithm we described earlier is the foundation for neural networks to learn, we can use several techniques to
improve the way neural networks learn. There techniques include: 

- cross-entropy function
- four regularization methods
  - L1 regularization
  - L2 regularization
  - dropout
  - artifical expansion of the training data
- A better method for initializing the weights in the network
- A set of heuristics to help choose good hyper-parameters for the network

## Cross-entropy cost function

We hope our neuron networks learn from their errors fast, however for the quadratic cost function the learning speech is dependent
on the initial values of weights and parameters. Let's use a simple neuron as the example. 

![Simple Neuron](/assets/images/simple-neuron.png)

We will train the neuron to take the input 1 and output 0. For the same learning rate $$\eta = 0.15$$, if the initial values of
weight w and bias b is different the learning speech may significantly different. We can see that example 2 learns very slowly (
the value of cost function decreases very slowly). It shows that when the result is badly wrong, our neural network cannot learn
from the error fast.

![Example 1](/assets/images/learn-1.png)

![Example 2](/assets/images/learn-2.png)

The neural network learns by changing the weights and biases at a rate determined by the partial derivatives of the cost function,
$$\partial C / \partial w$$ and $$\partial C / \partial b$$. For this simple example, we have

$$
C = \frac {(y-a)^2}{2} \\
a = \sigma (z) \\
z = wx +b \\
\frac {\partial C}{\partial w} = (a - y)\sigma '(z)x = a \sigma '(z) \\
\frac {\partial C}{\partial b} = (a - y)\sigma '(z) = a \sigma '(z) \\
x = 1 \\
y = 0 \\
$$

From the shape of the sigmoid function we know that when the output is close to 1, the curve gets very flat, so $$\sigma ' (z)$$
gets very small. This is the origin of learning slowdown. The cross-entropy cost function can help use to solve this problem. We 
define this cost function as follows:

$$
C = - \frac{1}{n} \sum _x [y ln a + (1 - y)ln (1 - a)]
$$

Replacing $$a$$ with $$\sigma (z)$$, we have

$$
\frac{\partial C}{\partial w_j} = - \frac{1}{n} \sum _x (\frac{y}{\sigma (z)} - \frac{(1-y)}{1- \sigma (z)}) \frac {\partial \sigma}{\partial w_j} \\
                                = - \frac{1}{n} \sum _x (\frac{y}{\sigma (z)} - \frac{(1-y)}{1- \sigma (z)}) \sigma '(z) x_j \\
                                =  \frac{1}{n} \sum _x \frac{\sigma '(z) x_j}{\sigma (z) (1 - \sigma (z))} (\sigma (z) - y) \\
                                = \frac{1}{n} \sum _x x_j (\sigma (z) - y)
$$

This equation shows the learning rate is controlled by the error in the output. In addition, the $$\sigma '(z)$$ part was canceled out
from the equation, we do not need to worry about it being small. Similarly, we get

$$
\frac{\partial C}{\partial b} = \frac{1}{n} \sum _x (\sigma (z) - y)
$$

## Softmax

The idea of **softmax** is to define a new type of output layer for our neural networks. Different with sigmoid neuron we apply
the softmax function the the weighted input $$z_j^L$$. 

$$
a_j^L = \frac{e^{z_j^L}}{\sum_k e^{z_k^L}}
$$

Assume the softmax layer has n inputs $$z_1^L, ..., z_n^L$$.
If we increase one of the input $$z_i^L$$, the output $$a_i^L$$ will increase and all the other outputs will decrease. On the 
contrary, if we decreases $$z_i^L$$, the output $$a_k^L$$ will decrease and all the other outputs will increase.
**The output activations are guaranteed to always sum up to 1**. The output of the softmax layer can be though of as a probability
distribution. 

### How does the softmax layer address the learning slowdown problem?

