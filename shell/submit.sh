#!/bin/bash
conda create --name devtools_scicomp python=3.9
source ~/miniconda3/etc/profile.d/conda.sh  
conda activate devtools_scicomp
python -m pip install pytest
git clone git@github.com:nanigabriele/devtools_scicomp_project_2025
cd devtools_scicomp_project_2025
touch README.md
git add README.md
git commit -m "first commit"
git push origin HEAD:main

mkdir src scripts test shell experiments src/pyclassify
touch src/pyclassify/__init__.py src/pyclassify/utils.py scripts/run.py shell/submit.sbatch shell/submit.sh experiments/config.yaml test/test_.py

python -m pip freeze > requirements.txt

cat <<EOF > pyproject.toml
# Choosing a build backend:
requires = ["setuptools"]
build-backend = "setuptools.build_meta"

[project]
name = "pyclassify"
version = "0.0.1"
description = "Project 2025 for the exam DevTools"
readme = "README.md"
requires-python = ">=3.9"
license = { file = "LICENSE" }
authors = [{ name = "Gabriele Nani", email = "nanigabriele99@gmail.com" }]
dynamic = ["dependencies"]

[tool.setuptools.packages.find]
where = ["src"]
exclude = ["scripts", "tests", "shell", "experiments"]

[tool.setuptools.dynamic]
dependencies = { file = ["requirements.txt"] }

[project.optional-dependencies]
test = ["pytest"]
EOF


cat <<EOF >> .gitignore
# Ignore data files
**/*.dat
**/*.data
EOF

git add .
git commit -m "structuring the package"
git push origin HEAD:main


