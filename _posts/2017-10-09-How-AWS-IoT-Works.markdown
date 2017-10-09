---
layout: post
categories: [AWS]
tags: [IoT]

---

AWS IoT is a cloud service that enables the secure communication between IoT devices and AWS cloud. 
IoT devices communication with AWS IoT with the [MQTT protocol](http://mqtt.org/), which uses light-weight subscribe/publish
message transport. From the previous figure, we can see that AWS IoT includes the following components:

![AWS IoT](/assets/images/aws_iot_data_services.png)



- **Message broker**: Things report their state to message broker with a specified topic. Message broker sends all messages published on an the topic to all subscribers of this topic.
- **Thing registry**: Thing registry stores information about a thing and the certificates that are used by the thing to secure communication with AWS IoT.
- **Thing shadow**: Each thing has a thing shadow that stores and retrieves state information. Each item in the state information has two entries: the state last reported by the thing and the desired state requested by an application. 
- **Rule engine**: You can use rule engine to create rules that define one or more actions, such as send an SQS message, to perform on the data in a message. Rules also contain an IAM role that grants AWS IoT permission to the AWS resources used to perform the action.
