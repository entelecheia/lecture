# Introduction to MLOps

Machine learning systems design is the process of creating and implementing machine learning models and algorithms that can solve real-world problems. This involves defining the software architecture, selecting the appropriate algorithms, and designing the infrastructure required for the system to meet specific requirements.

The design process typically involves several stages, such as collecting and preparing data, selecting relevant features, training and validating the model, and integrating it into the broader system or application. Additionally, monitoring and maintenance are essential to ensure that the machine learning system continues to perform accurately and efficiently over time.

MLOps, or Machine Learning Operations, is a related field that applies DevOps principles to machine learning systems. MLOps focuses on developing a software architecture that can handle the complexity and scalability of machine learning models, managing data, and infrastructure required for training and deploying models, and automating processes to improve efficiency and reliability.

Machine learning systems design and MLOps are critical to ensuring the success of machine learning projects, improving the accuracy and efficiency of models, and delivering value to users and customers.

```{figure} ../figs/mlops/intro/mlops-cycle.png
---
width: 400px
name: fig-mlops-cycle
---
The MLOps cycle.
```

- Machine learning systems design involves creating and implementing machine learning models and algorithms to solve real-world problems.
- The design process includes defining software architecture, selecting algorithms, and designing infrastructure to meet specific requirements.
- The design stages include collecting and preparing data, selecting relevant features, training and validating the model, and integrating it into a broader system or application.
- Monitoring and maintenance are crucial to ensure the machine learning system performs accurately and efficiently over time.
- MLOps applies DevOps principles to machine learning systems to develop a software architecture capable of handling complexity and scalability, manage data and infrastructure, and automate processes for efficiency and reliability.
- Machine learning systems design and MLOps are essential to ensure project success, improve model accuracy and efficiency, and deliver value to users and customers.

## Hidden Technical Debt in Machine Learning Systems

```{figure} ../figs/mlops/intro/mlcode.png
---
width: 700px
name: fig-mlops-cycle
---
Only a small fraction of real-world ML systems is composed of the ML code {cite:p}`sculley2015hidden`
```

Building a real-world machine learning system involves much more than just writing the machine learning code. In fact, only a small fraction of the overall system is typically composed of the machine learning code. Building a successful machine learning system requires expertise in various areas, including machine learning algorithms and models, data engineering, software engineering, DevOps, and more. It is a complex and challenging task that requires careful planning, design, and execution.

- Building a real-world machine learning system involves more than just writing the machine learning code. It requires expertise in various areas, including machine learning algorithms and models, data engineering, software engineering, and DevOps.
- Building a successful machine learning system requires careful planning, design, and execution due to its complexity and challenging nature.

## MLOps: Continuous delivery and automation pipelines in machine learning

One of the key components of MLOps is the use of continuous delivery and automation pipelines to streamline the process of building and deploying machine learning models.

Continuous delivery involves automating the process of building, testing, and deploying machine learning models, allowing teams to quickly and reliably release new versions of their models into production. Automation pipelines are designed to perform a series of tasks automatically, reducing the risk of human error and improving the speed and efficiency of the process.

For example, data collection and preparation can be automated using tools like Apache Airflow or Kubeflow, which can handle tasks like data cleaning, transformation, and feature engineering. Model training and evaluation can be automated using tools like TensorFlow or PyTorch, which can perform tasks like hyperparameter tuning and model validation.

Model deployment can be automated using tools like Kubernetes or AWS SageMaker, which can handle tasks like model packaging, versioning, and scaling. Monitoring and maintenance can be automated using tools like Prometheus or Grafana, which can provide real-time metrics and alerts to ensure the model is performing as expected.

By using continuous delivery and automation pipelines in machine learning, teams can reduce the time and resources required to deploy and maintain their models, improve their accuracy and reliability, and deliver more value to their users and customers.

- MLOps uses continuous delivery and automation pipelines to streamline the building and deploying of machine learning models.
- Automation tools like Apache Airflow, TensorFlow, Kubernetes, and Prometheus can automate data collection, preparation, feature engineering, model training and validation, deployment, monitoring, and maintenance.
- By using continuous delivery and automation pipelines, teams can reduce time and resources required to deploy and maintain models, improve accuracy and reliability, and deliver more value to users and customers.

## DevOps versus MLOps

## Machine Learning Layered on DevOps
