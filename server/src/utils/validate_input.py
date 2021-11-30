def valid_username(inp):
    for character in inp:
        character_code = ord(character)
        if character_code <= 57 and character_code >= 48:
            pass
        elif character_code >= 65 and character_code <= 90:
            pass
        elif character_code >= 97 and character_code <= 122:
            pass
        else:
            return None
    if len(inp) > 10:
        return None
    return inp


def valid_password(inp):
    return (len(inp) < 12) and inp or None

def valid_pubkey(inp):
    return (len(inp) == 418) and inp or None