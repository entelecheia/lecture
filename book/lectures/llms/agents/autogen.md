# AutoGen

AutoGen, developed by Microsoft in collaboration with Penn State University and University of Washington, is a framework designed for creating Large Language Model (LLM) applications through multi-agent conversations. It significantly simplifies the automation, orchestration, and optimization of complex LLM workflows, thus making the development of next-generation LLM applications more accessible. This framework provides a structured environment for agents to interact and solve tasks autonomously or with human intervention. The installation and utilization of AutoGen require a specific set of steps and understanding of its core components which include setting up a virtual environment, installing necessary dependencies, and executing multi-agent conversations. This tutorial aims to provide a comprehensive guide on setting up and using AutoGen for developing LLM applications.

## Installation

- **Setting Up a Virtual Environment**:
  It's advisable to create a virtual environment to keep AutoGen's dependencies isolated. Two options are available: `venv` and `conda`. Here are the commands for each:
  - Using `venv`:
    ```bash
    python3 -m venv pyautogen
    source pyautogen/bin/activate
    deactivate  # to deactivate the environment
    ```
  - Using `conda`:
    ```bash
    conda create -n pyautogen python=3.10  # python 3.10 is recommended
    conda activate pyautogen
    conda deactivate  # to deactivate the environment
    ```
- **Python and AutoGen Installation**:
  Ensure you have Python version >= 3.8. Install AutoGen using pip:
  ```bash
  pip install pyautogen
  ```
- **Optional Dependencies**:
  Install additional packages based on your requirements:
  ```bash
  pip install docker  # for seamless code execution
  pip install "pyautogen[blendsearch]"  # for hyperparameter optimization
  pip install "pyautogen[retrievechat]"  # for retrieval-augmented generation tasks
  pip install "pyautogen[mathchat]"  # for math problem solving
  ```

## Framework Overview

AutoGen facilitates the development of applications where multiple agents interact to solve tasks. It supports diverse conversation patterns, enabling complex workflows with different levels of conversation autonomy, agent numbers, and conversation topology【14†source】.

## Executing Multi-Agent Conversations

A simple example is provided in the official documentation where two agents, `AssistantAgent` and `UserProxyAgent`, are created to perform a task:

```python
from autogen import AssistantAgent, UserProxyAgent, config_list_from_json
config_list = config_list_from_json(env_or_file="OAI_CONFIG_LIST")
assistant = AssistantAgent("assistant", llm_config={"config_list": config_list})
user_proxy = UserProxyAgent("user_proxy", code_execution_config={"work_dir": "coding"})
user_proxy.initiate_chat(assistant, message="Plot a chart of NVDA and TESLA stock price change YTD.")
```

This example showcases an automated chat between two agents to solve a specific task【14†source】.

## Enhanced LLM Inferences

AutoGen provides enhanced LLM inference capabilities such as tuning, caching, error handling, and templating. For instance, you can optimize generations by LLM with your own tuning data, success metrics, and budgets【14†source】.
