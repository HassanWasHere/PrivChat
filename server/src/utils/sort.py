# This is for my merge sort to sort messages by time sent


def merge_elements(left_side, right_side): 
    lefti, righti, output = 0, 0, []
    while lefti < len(left_side) and righti < len(right_side): # The merge_elements function will use a while loop to go through the left and right side and compare elements. 
        if left_side[lefti] < right_side[righti]:
            output.append(left_side[lefti])
            lefti = lefti + 1
        else:
            output.append(right_side[righti])
            righti = righti + 1
    # Whichever side has the smaller number, will be added into the output array first and have it’s array index increased (so the next item in that array will be compared). 
    output += left_side[lefti:]
    output += right_side[righti:]
    return output # This means that the final output of this function is both arrays combined into one array that is fully sorted. 

def merge_sort(messages): # The merge_sort function will take in one array as an input. 
    # This array will contain the messages that needs to be merge sorted. 
    # I've overriden the comparison operators on the message class for >, < and = to compare with time_sent to make this easier.
    if len(messages) <= 1: # The merge_sort function will need a base case, if the length of the array is one 
        return messages # then the recursion loop will exit and return that element. 

    midpoint = len(messages) // 2 # Gets the midpoint 
    left = merge_sort(messages[:midpoint]) # Get the first half of the list
    right = merge_sort(messages[midpoint:]) # Get second half of the list
    # the merge_sort will be splitting the given array in two, then repeatedly calling itself until it’s split the one array into individual elements. 

    return merge_elements(left, right) # Return all the elements merged and sorted
