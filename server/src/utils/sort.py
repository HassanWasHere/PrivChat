def split_elements(left_side, right_side):
    lefti, righti, output = 0, 0, []
    while lefti < len(left_side) and righti < len(right_side):
        if left_side[lefti] < right_side[righti]:
            output.append(left_side[lefti])
            lefti = lefti + 1
        else:
            output.append(right_side[righti])
            righti = righti + 1

    output += left_side[lefti:]
    output += right_side[righti:]
    return output

def merge_sort(messages):
    if len(messages) <= 1:
        return messages

    midpoint = len(messages) // 2
    left = merge_sort(messages[:midpoint])
    right = merge_sort(messages[midpoint:])

    return split_elements(left, right)
