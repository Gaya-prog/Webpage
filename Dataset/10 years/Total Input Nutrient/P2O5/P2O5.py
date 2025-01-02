import pandas as pd
import os

# Load the dataset
file_path = "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/Inputs_FertilizersNutrient_E_All_Data_NOFLAG.csv"
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
years = [f"Y{year}" for year in range(2008, 2023)]
columns_to_extract += years

# Extract the desired columns
selected_columns = data[columns_to_extract].copy()  # Use .copy() to avoid SettingWithCopyWarning

# Check for missing data
missing_data = selected_columns.isnull()
if missing_data.any().any():
    print("Yes, there is missing data.")
else:
    print("No, there is no missing data.")

# Filter rows with sufficient valid data
selected_columns["ValidDataCount"] = selected_columns[years].notnull().sum(axis=1)
filtered_columns = selected_columns[selected_columns["ValidDataCount"] >= 9].copy()  # Fix with .copy()

# Debugging: Inspect raw data range before imputation
print("\nRaw data summary before imputation:")
print(filtered_columns[years].describe())

# Estimate missing values using median imputation instead of mean
for year in years:
    # Use the median value (ignoring NaNs)
    median_value = filtered_columns[year].median(skipna=True)
    # Replace missing values with this median value
    filtered_columns[year] = filtered_columns[year].fillna(median_value)

# Debugging: Inspect the imputed values to confirm they aren't excessively large
print("\nData summary after median-based imputation:")
print(filtered_columns[years].describe())

# Remove the helper column after filtering
filtered_columns.drop(columns=["ValidDataCount"], inplace=True)

# Further filter rows based on your logical conditions
filtered_data = filtered_columns[
    (filtered_columns["Element"] == "Use per area of cropland") &
    (filtered_columns["Item"].isin(["Nutrient phosphate P2O5 (total)"]))
]

# Ensure save directory exists
output_dir = "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/"
os.makedirs(output_dir, exist_ok=True)

# Save filtered data to CSV
if not filtered_data.empty:
    output_file_path = os.path.join(output_dir, "FilteredData_Min15Years_P2O5total.csv")
    filtered_data.to_csv(output_file_path, index=False)
    print(f"Filtered data saved successfully to {output_file_path}")
else:
    print("No data matched the filtering criteria.")
