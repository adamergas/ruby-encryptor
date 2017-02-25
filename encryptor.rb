class Encryptor

  def cipher(rotation)
    characters = (" ".."z").to_a
    rotated_characters = characters.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(string, rotation)
    letters = string.split("")
    code = letters.collect do |letter|
      encrypt_letter(letter, rotation)
    end
    code.join
  end

  def decrypt(string, rotation)
    letters = string.split("")
    code = letters.collect do |letter|
      encrypt_letter(letter, -rotation)
    end
    code.join
  end

  def encrypt_file(filename, rotation)
    input = File.open(filename, "r")
    text = input.read
    encrypted_text = encrypt(text, rotation)
    outname = "#{filename}.encrypted"
    output = File.open(outname, "w")
    output.write(encrypted_text)
    output.close
  end

  def decrypt_file(filename, rotation)
    input = File.open(filename, "r")
    encrypted_text = input.read
    decrypted_text = decrypt(encrypted_text, rotation)
    outname = filename.gsub(".encrypted", ".decrypted")
    output = File.open(outname, "w")
    output.write(decrypted_text)
    output.close
  end

  def supported_characters
    (" ".."z").to_a
  end

  def crack(message)
    supported_characters.count.times.collect do |attempt|
      decrypt(message, attempt)
    end
  end

end
