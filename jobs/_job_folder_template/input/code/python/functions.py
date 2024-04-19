## ############################################ ##
##           *** Functions File ***             ##
## Used for defining global functions.          ##
## ############################################ ##

def example_func(sequence: list, lookup: dict, prefix: str = 'example', multiplier: int = 1):
    """
    An example function for demonstration purposes only.
    Multiplies stored values for each value in a list by a given integer.
    
    Params:
    -------
    prefix : str, default 'example'
        Prefix for printed output
    multiplier : int, default 1
        Multiplication factor
    sequence : list
        Keys for obtaining stored values
    lookup : dict
        Stored values to be multiplied
        
    Returns:
    --------
    output_list : list
        Multiplied values with prefix and key
        
    """
    
    output_list = []
    
    if sequence is None:
        print('No lookup keys provided.')
        return None
    
    for s in sequence:
        try:
            stored_value = lookup[s]
            output_list.append(f'{prefix} {s}: {stored_value * multiplier}')
        except:
            continue
        
    return output_list