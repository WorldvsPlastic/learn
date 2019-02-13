
import json
from setuptools import setup, find_packages

# Load package.json contents
with open("package.json") as data:
    package = json.load(data)

# Load list of dependencies
with open("requirements.txt") as data:
    install_requires = [
        line for line in data.read().split("\n")
            if line and not line.startswith("#")
    ]

# Package description
setup(
    name = package["name"],
    version = package["version"],
    url = package["homepage"],
    license = package["license"],
    description = package["description"],
    author = package["author"]["name"],
    author_email = package["author"]["email"],
    keywords = package["keywords"],
    packages = find_packages(),
    include_package_data = True,
    install_requires = install_requires,
    entry_points = {
        "mkdocs.themes": [
            "material = material",
        ]
    },
    zip_safe = False
)
