import json

emoji = []

# Load the JSON file
with open('./assets/mutant_output.json') as json_file:
	data = json.load(json_file)
	for i in data:
		# Skip weird stuff like color modifiers
		if i["root"] == "!undefined":
			continue
		emoji.append(i["short"])

# Write the JSON file
with open('./assets/emoji_list.json', 'w') as json_file:
	json.dump(emoji, json_file)
