temp = 78

def set_temp(tmp):
    print("In set_tmp. Setting temperature to", tmp)

if temp > 70:
    print("It's hot in here. Turning down the temperature.")
    new_temp = temp - 2
    set_temp(new_temp)
