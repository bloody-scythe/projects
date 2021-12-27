import time

def measure_time(func):
    def wrapper(*arg):
        t = time.time()
        res = func(*arg)
        print("Function took " + str(time.time()-t) + " seconds to run")
        return res
    return wrapper
