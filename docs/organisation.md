# Project Organisation

## Style:

- use snake_case for file and folder names
- use PascalCase (not camel) for node names
- third party components are to be placed in the addons folder for easy identification (they are to be eventually replaced).

## Folder Structure:

```tml
/[project_name].godot

/main.tscn

/icon.png

/addons/* # Temporary third party tools and assets

/buildings/* # Placeable buildings

/characters/* # Player and AI of all forms

/controllers/*

/levels/*

/objects/* # Dynamic and static placeable objects

/objects/static/storage/* # Storage type objects

/objects/dynamic/equipment/* # Character equipables

/ui/*
```