# Larder

Larder is a prototype iOS app for choosing recipes from a personal library and turning them into a shopping list.

## Current idea

1. Browse recipes in the library.
2. Select one or more recipes and choose their serving sizes.
3. Generate a combined shopping list.
4. Check items off while shopping.

The prototype combines matching ingredients, converts compatible units, and groups the result by category.

## Status

This is the first round of development. The project is intentionally simple and still uses placeholder data and UI in places.

## Project structure

- `LarderApp/Models` - SwiftData models for recipes, ingredients, and shopping lists
- `LarderApp/Services` - ingredient merging and unit conversion
- `LarderApp/ViewModels` - recipe selection and shopping-list state
- `LarderApp/Views` - recipe library, recipe details, and shopping-list screens

## Running locally

Open the project in Xcode and run it on an iOS simulator or device.

> TODO: Add the Xcode project, supported iOS version, and setup instructions.

## Possible next steps

- Add recipe creation and editing
- Add a real recipe data source and sample recipes
- Persist generated shopping lists
- Add tests for ingredient merging and unit conversion
- Improve recipe search and filtering
