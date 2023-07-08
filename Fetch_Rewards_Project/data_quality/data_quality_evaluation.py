import os  
import json  
  
# Load JSON data from files  
def load_data(file_path):  
    data = []  
    with open(file_path, 'r') as f:  
        for line in f:  
            if line.strip():  
                data.append(json.loads(line))  
    return data  
  
brands_data = load_data('../data/brands.json')  
receipts_data = load_data('../data/receipts.json')  
users_data = load_data('../data/users.json')  
  
# Check for missing or null values in data  

  
def check_data_quality(data, data_name):  
    issues = False  
  
    # Get the expected fields from the first item in the data  
    expected_fields = set(data[0].keys())  
  
    # Create an output file for the data quality report  
    output_file_path = os.path.join(os.getcwd(), f"{data_name}_quality_report.txt")  
    with open(output_file_path, "w") as output_file:  
  
        def check_missing_values(item, data_name):  
            nonlocal issues  
            item_fields = set(item.keys())  
            missing_fields = expected_fields - item_fields  
  
            if missing_fields:  
                output_file.write(f"Data quality issue: Missing fields {', '.join(missing_fields)} in {data_name}\n")  
                issues = True  
  
            for key, value in item.items():  
                if value is None or value == "":  
                    output_file.write(f"Data quality issue: Null value for '{key}' in {data_name}\n")  
                    issues = True  
                elif isinstance(value, dict):  
                    check_missing_values(value, data_name)  
                elif isinstance(value, list):  
                    for element in value:  
                        if isinstance(element, dict):  
                            check_missing_values(element, data_name)  
  
        for item in data:  
            check_missing_values(item, data_name)  
  
        if not issues:  
            output_file.write(f"No data quality issues found in {data_name}\n")  
  
check_data_quality(brands_data, "Brands_data")  
check_data_quality(receipts_data, "Receipts_data")  
check_data_quality(users_data, "Users_data")  
