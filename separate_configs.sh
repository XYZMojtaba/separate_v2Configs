#!/bin/bash

# Prompt the user for the input file name
echo "Please enter the input file name:"
read input_file

# Check if the input file exists
if [ ! -f "$input_file" ]; then
  echo "File not found. Please make sure the file exists and try again."
  exit 1
fi

# Temporary files
temp_vmess=$(mktemp)
temp_vless=$(mktemp)
temp_ss=$(mktemp)
temp_hysteria=$(mktemp)
temp_tuic=$(mktemp)
temp_trojan=$(mktemp)
temp_hysteria2=$(mktemp)
temp_hy2=$(mktemp)
temp_wireguard=$(mktemp)
temp_other=$(mktemp)

# Read lines from the input file and categorize them
while IFS= read -r line; do
  case "$line" in
    vmess://*)
      echo "$line" >> "$temp_vmess"
      ;;
    vless://*)
      echo "$line" >> "$temp_vless"
      ;;
    ss://*)
      echo "$line" >> "$temp_ss"
      ;;
    hysteria://*)
      echo "$line" >> "$temp_hysteria"
      ;;
    tuic://*)
      echo "$line" >> "$temp_tuic"
      ;;
    trojan://*)
      echo "$line" >> "$temp_trojan"
      ;;
    hysteria2://*)
      echo "$line" >> "$temp_hysteria2"
      ;;
    hy2://*)
      echo "$line" >> "$temp_hy2"
      ;;
    wireguard://*)
      echo "$line" >> "$temp_wireguard"
      ;;
    *)
      echo "$line" >> "$temp_other"
      ;;
  esac
done < "$input_file"

# Create output files only if configurations exist
output_file_base="${input_file%.*}"

[ -s "$temp_vmess" ] && mv "$temp_vmess" "${output_file_base}_vmess.txt" || rm "$temp_vmess"
[ -s "$temp_vless" ] && mv "$temp_vless" "${output_file_base}_vless.txt" || rm "$temp_vless"
[ -s "$temp_ss" ] && mv "$temp_ss" "${output_file_base}_ss.txt" || rm "$temp_ss"
[ -s "$temp_hysteria" ] && mv "$temp_hysteria" "${output_file_base}_hysteria.txt" || rm "$temp_hysteria"
[ -s "$temp_tuic" ] && mv "$temp_tuic" "${output_file_base}_tuic.txt" || rm "$temp_tuic"
[ -s "$temp_trojan" ] && mv "$temp_trojan" "${output_file_base}_trojan.txt" || rm "$temp_trojan"
[ -s "$temp_hysteria2" ] && mv "$temp_hysteria2" "${output_file_base}_hysteria2.txt" || rm "$temp_hysteria2"
[ -s "$temp_hy2" ] && mv "$temp_hy2" "${output_file_base}_hy2.txt" || rm "$temp_hy2"
[ -s "$temp_wireguard" ] && mv "$temp_wireguard" "${output_file_base}_wireguard.txt" || rm "$temp_wireguard"
[ -s "$temp_other" ] && mv "$temp_other" "${output_file_base}_other.txt" || rm "$temp_other"

echo "Configuration categorization complete."
