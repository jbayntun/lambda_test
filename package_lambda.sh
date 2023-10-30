#!/bin/bash

# Define paths
LAMBDA_FUNCTION_NAME="resizer"
DEPLOYMENT_DIR="deployment"
ZIP_FILE_NAME="resizer.zip"

# Cleanup any previous deployment package and directory
rm -rf $DEPLOYMENT_DIR $ZIP_FILE_NAME

# Create the deployment directory
mkdir $DEPLOYMENT_DIR

# Install Python dependencies
pip3 install -r requirements.txt -t $DEPLOYMENT_DIR

# Copy the Lambda function code into the deployment directory
cp $LAMBDA_FUNCTION_NAME.py $DEPLOYMENT_DIR/

# Navigate into the deployment directory
cd $DEPLOYMENT_DIR

# Create a ZIP package
zip -r ../$ZIP_FILE_NAME .

# Navigate back to the original directory
cd ..

# Output the path to the ZIP file
echo "Deployment package created at: $(pwd)/$ZIP_FILE_NAME"
