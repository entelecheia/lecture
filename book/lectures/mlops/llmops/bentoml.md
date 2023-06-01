# Introduction to BentoML

BentoML is a flexible, high-performance framework for serving, managing, and deploying machine learning models. It bridges the gap between Data Science and DevOps, making it easier to turn a machine learning model into a production-ready API endpoint.

BentoML supports a wide range of ML frameworks and libraries out of the box including PyTorch, Scikit-learn, Tensorflow, Keras, H2O, XGBoost and many more.

## Why BentoML?

Machine learning models are more than just the algorithms. They include pre-processing steps, post-processing steps, feature extraction code, and possibly lookup tables or reference datasets. All these components are crucial for a model to make accurate predictions in production.

However, when moving from development to production, these components can become scattered and disjointed, leading to potential issues and bugs. BentoML solves this problem by providing a standard way to package all these components together into a single, versioned file that can be easily distributed and deployed.

## Core Concepts of BentoML

- **BentoService**: A BentoService is a prediction service defined by the user, with all its dependencies and configurations. It's a way to package your model into a Docker image or a Python package for distribution.

- **Artifacts**: Artifacts are the trained models. BentoML provides a flexible way to manage and distribute trained ML models as part of a BentoService.

- **Adapters**: Adapters convert incoming data into a format that your prediction service can handle. BentoML supports a wide range of input data types out of the box.

- **Deployment**: Once your model is packaged into a BentoService, BentoML provides a variety of ways to deploy your model to cloud services like AWS Lambda, Google Cloud Run, or Azure Functions, as well as edge devices for offline inference.

In the following sections, we will dive deeper into each of these concepts and demonstrate how to use BentoML to train a model, package it, and deploy it to a cloud service.

### BentoService

A BentoService is a container for packaging a trained ML model, along with its pre-processing, post-processing code, dependencies, and configurations. It is a prediction service defined by the user.

Each BentoService is a versioned file that can be easily distributed and deployed. It can be converted into a Docker image, a REST API server, a command-line tool, or a PyPI package, providing a straightforward way to ship your ML models to production.

Here is an example of a simple BentoService:

```python
from bentoml import env, artifacts, api, BentoService
from bentoml.adapters import DataframeInput
from bentoml.frameworks.sklearn import SklearnModelArtifact

@env(auto_pip_dependencies=True)
@artifacts([SklearnModelArtifact('model')])
class IrisClassifier(BentoService):

    @api(input=DataframeInput(), batch=True)
    def predict(self, df):
        return self.artifacts.model.predict(df)
```

### Artifacts

Artifacts in BentoML represent the trained machine learning models. They are an essential part of a BentoService. BentoML provides a flexible way to manage and distribute trained ML models as part of a BentoService.

BentoML supports a wide range of ML frameworks and libraries out of the box. Each type of model or dataset is represented by a different class of Artifact in BentoML, such as `SklearnModelArtifact`, `PytorchModelArtifact`, `FastaiModelArtifact`, and more.

Here is an example of how to pack a trained model into a BentoService:

```python
# Train the model
from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import load_iris

iris = load_iris()
model = RandomForestClassifier()
model.fit(iris.data, iris.target)

# Create a BentoService instance
iris_classifier_service = IrisClassifier()

# Pack the trained model
iris_classifier_service.pack('model', model)
```

### Adapters

Adapters in BentoML are used to define the expected input format for a BentoService API. They convert incoming request data into the required format for your prediction service.

BentoML supports a wide range of input data types out of the box, including JSON, Image, CSV, and more. For example, the `DataframeInput` adapter converts incoming data into a pandas DataFrame.

Here is an example of defining an API with a DataframeInput adapter:

```python
@api(input=DataframeInput(), batch=True)
def predict(self, df):
    return self.artifacts.model.predict(df)
```

### Deployment

Once your model is packaged into a BentoService, BentoML provides a variety of ways to deploy your model. You can deploy your model as a web service using platforms like AWS Lambda, Google Cloud Run, or Azure Functions. You can also deploy your model on edge devices for offline inference.

Here is an example of how to save a BentoService to file, which can then be deployed:

```python
# Save the BentoService to file
saved_path = iris_classifier_service.save()
```

## Frameworks Supported by BentoML

BentoML is designed to be framework agnostic, supporting a wide range of machine learning frameworks out of the box. This allows you to use BentoML with your preferred machine learning library, making it a flexible tool for model serving and deployment. Here are some of the key frameworks supported:

### Scikit-learn

Scikit-learn is a popular machine learning library in Python, known for its simplicity and efficiency. It provides a range of supervised and unsupervised learning algorithms. BentoML supports Scikit-learn models through the `SklearnModelArtifact` class, allowing you to easily package and deploy your Scikit-learn models.

### PyTorch

PyTorch is a powerful open-source machine learning library for Python, known for its flexibility and deep learning capabilities. BentoML supports PyTorch models through the `PytorchModelArtifact` class, allowing you to package and deploy models trained with PyTorch.

### TensorFlow and Keras

TensorFlow is a comprehensive open-source machine learning platform with a wide array of tools for building and deploying ML-powered applications. Keras is a user-friendly neural network library written in Python that runs on top of TensorFlow. BentoML supports both TensorFlow and Keras models through the `TensorflowSavedModelArtifact` and `KerasModelArtifact` classes, respectively.

### XGBoost and LightGBM

XGBoost and LightGBM are gradient boosting frameworks that use tree-based learning algorithms. They are known for their performance and efficiency. BentoML supports both XGBoost and LightGBM models through the `XgboostModelArtifact` and `LightGBMModelArtifact` classes, respectively.

### H2O

H2O is an open-source software for data analysis, with capabilities for data munging, advanced algorithms, and more. BentoML supports H2O models through the `H2oModelArtifact` class.

### Fast.ai

Fast.ai is a deep learning library built on top of PyTorch, designed to make deep learning more accessible. BentoML supports Fast.ai models through the `FastaiModelArtifact` class.

In conclusion, BentoML's support for a wide range of machine learning frameworks makes it a versatile tool for model serving and deployment, regardless of the framework you use for model training.

## Deployment Guides with BentoML

BentoML provides comprehensive guides for deploying your machine learning models on various platforms. Here's an overview of how you can deploy your models using BentoML:

### Docker

BentoML can automatically package your model as a Docker image, with a REST API server serving your model for online prediction requests. You can build and push this Docker image to a Docker registry, and then deploy it on any platform that supports Docker.

### Kubernetes

BentoML supports deploying your models on Kubernetes, a popular open-source platform for managing containerized workloads and services. You can use the BentoML API server image in a Kubernetes Deployment and expose it as a service.

### AWS Lambda

BentoML provides a command-line tool for deploying your model as a serverless function on AWS Lambda, a service that lets you run your code without provisioning or managing servers. The serverless function can be triggered by an HTTP request and scale automatically.

### Google Cloud Run

Google Cloud Run is a managed compute platform that enables you to run stateless containers that are invocable via HTTP requests. BentoML supports deploying your models on Google Cloud Run, allowing you to take advantage of its auto-scaling capabilities.

### Azure Functions

Azure Functions is a serverless compute service that lets you run event-triggered code without having to explicitly provision or manage infrastructure. BentoML supports deploying your models on Azure Functions, providing you with another option for serverless deployment.

### Offline Batch Serving

BentoML also supports offline batch serving, allowing you to run prediction jobs on large datasets and save the results to a file system or a cloud storage service.

Each of these deployment guides provides step-by-step instructions on how to deploy your BentoService on the respective platform. They also include information on how to manage and monitor your deployed models, ensuring that you can effectively operate your models in production.

## References

- [BentoML Documentation](https://docs.bentoml.org/en/latest/)
