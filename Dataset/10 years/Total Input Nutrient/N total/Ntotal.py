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
selected_columns = data[required_columns].copy()

# Convert year columns to numeric
selected_columns[years] = selected_columns[years].apply(pd.to_numeric, errors="coerce")

# Identify outliers and replace with NaN
for year in years:
    year_mean = selected_columns[year].mean(skipna=True)
    year_std = selected_columns[year].std(skipna=True)
    upper_limit = year_mean + 3 * year_std
    lower_limit = year_mean - 3 * year_std
    selected_columns.loc[
        (selected_columns[year] > upper_limit) | (selected_columns[year] < lower_limit), year
    ] = None

# Check for missing data
missing_data = selected_columns[years].isnull().sum()
print("\nMissing Data by Year (after handling outliers):")
print(missing_data)

# Filter rows with sufficient valid data (at least 9 years of valid data)
selected_columns["ValidDataCount"] = selected_columns[years].notnull().sum(axis=1)
filtered_columns = selected_columns[selected_columns["ValidDataCount"] >= 13]
if filtered_columns.empty:
    print("No rows with sufficient valid data. Exiting.")
    exit()

# Estimate missing values using median or interpolation
for year in years:
    median_value = filtered_columns[year].median(skipna=True)
    filtered_columns[year] = filtered_columns[year].fillna(median_value)

# Interpolate for smoother trend estimation
filtered_columns[years] = filtered_columns[years].interpolate(axis=1, limit_direction="both")

# Remove the helper column
filtered_columns.drop(columns=["ValidDataCount"], inplace=True)

# Further filter rows based on logical conditions
filtered_data = filtered_columns[
    (filtered_columns["Element"] == "Use per area of cropland") &
    (filtered_columns["Item"] == "Nutrient nitrogen N (total)")
]

# Ensure save directory exists and has write permission
output_dir = "C:/Users/mgaya/OneDrive/Documents/Nanofertech/Webpage/Dataset/10 years/"
os.makedirs(output_dir, exist_ok=True)

# Save filtered data to CSV
if not filtered_data.empty:
    output_file_path = os.path.join(output_dir, "FilteredData_Min15Years_Ntotal.csv")
    filtered_data.to_csv(output_file_path, index=False)
    print(f"\nFiltered data saved successfully to {output_file_path}")
else:
    print("\nNo data matched the filtering criteria.")
