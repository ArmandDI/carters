# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:percent
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.13.1
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# %% [markdown]
# # Example Notebook
#
# This example notebook demonstrates how to use functions and configuration files rather than defining functions and parameters in the notebook itself.
# Not only does this keep things cleaner, it makes it easier for people to collaborate on the project.
# Larger projects may require multiple functions or configuration files so that people are less likely to modify the same file at the same time.

# %%
# Import functions
from input.code.python import functions as f

# Import configuration file
from input.code.python import config as c

# %%
f.example_func(
    sequence = c.example_list,                   
    lookup = c.example_dict,
    prefix = c.example_str,
    multiplier = c.example_int
)

# %% [markdown]
# ## SQL
#
# It can also be beneficial to store SQL scripts separately and call them as needed, rather than embedding the SQL in the notebook itself.

# %%
print(c.example_sql_path)

# %%
with open(c.example_sql_path, 'r') as file:
    example_sql = file.read() 

# %%
print(example_sql)
