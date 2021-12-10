# This module is used to make sure the username, password and public key
# supplied by the client are correct
def valid_username(inp): # This function takes a potential username as a String as an input
    for character in inp: # It uses a for loop to iterate through every character
        character_code = ord(character) # It converts it to a character code
        if character_code <= 57 and character_code >= 48: # Use selection to check if it's  lower case
            pass # Do nothing as lower case it allowed
        elif character_code >= 65 and character_code <= 90: # Use selection to check if it's upper case
            pass # Do nothing as it's allowed
        elif character_code >= 97 and character_code <= 122: # Use selection to check if it's a number
            pass # Do nothing as it's allowed
        else: # But if it's not lower case, upper case or a number
            return None # Return nothing
    if len(inp) > 10: # If the length of the username is more than 10
        return None # It's not allowed so return nothing
    return inp # Return the password if it's allowed and 'None' hasn't been returned already


def valid_password(inp): # This function takes a potential password as a String as an input
    return (len(inp) < 12) and inp or None # Return the password if the length is less than 12 or return nothing

def valid_pubkey(inp): # This function takes a potential public key as a String as an input
    return (len(inp) == 418) and inp or None # Return the public key if the length is less than 12 or return nothing