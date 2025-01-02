import pandas as pd

# Load the dataset
file_path = "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/Inputs_FertilizersNutrient_E_All_Data_NOFLAG.csv"  # Replace with your file path
data = pd.read_csv(file_path, encoding='latin-1')

# Check for required columns
years = [f"Y{year}" for year in range(2008, 2023)]
required_columns = ["Area", "Item", "Element", "Unit"] + years
missing_columns = [col for col in required_columns if col not in data.columns]
if missing_columns:
    raise ValueError(f"The following required columns are missing in the dataset: {missing_columns}")

# Descriptive summary
print("Dataset Descriptive Summary:")
print(f"Total rows: {data.shape[0]}")
print(f"Total columns: {data.shape[1]}")
print(f"Column names: {list(data.columns)}")
print("\nUnique areas (countries):", data['Area'].nunique())
print("Unique items:", data['Item'].nunique())
print("Unique elements:", data['Element'].nunique())
print("\nPreview of unique areas (countries):")
print(data['Area'].unique()[:10])  # Show the first 10 unique areas
print("\nBasic Statistics for Numerical Columns:")
print(data.describe())

# Select specific columns
columns_to_extract = ["Area", "Item", "Element", "Unit"]

# List of years from 1961 to 2022
years = [f"Y{year}" for year in range(2008, 2023)]  

# Combine the column names and years
columns_to_extract += years

# Filter the dataset to include only the specified columns
selected_columns = data[columns_to_extract]

# Filter rows where 'Element' is 'Production', 'Import Quantity', or 'Export Quantity'
filtered_data = selected_columns[selected_columns["Element"].isin(["Production", "Import Quantity", "Export Quantity"])& 
         (selected_columns["Item"].isin(["Nutrient nitrogen N (total)"]))
         ]

# Apply the minimum 9 data rule (at least 9 non-null values in the year columns)
filtered_data = filtered_data[filtered_data[years].notnull().sum(axis=1) >= 10]

# Estimate missing values by using the mean of each row
for year in years:
    filtered_data[year] = filtered_data[year].fillna(filtered_data[year].mean())

# Drop the helper column if it exists (check if "ValidDataCount" exists first)
if "ValidDataCount" in filtered_data.columns:
    filtered_data = filtered_data.drop(columns=["ValidDataCount"])

# Display the filtered data
print("Filtered data preview:")
print(filtered_data.head())

# Save filtered data to a new CSV file
output_file_path = "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/production_data.csv"
filtered_data.to_csv(output_file_path, index=False)
print(f"Filtered data saved successfully to {output_file_path}")
