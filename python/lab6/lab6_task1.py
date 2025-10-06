nums = [1, -2, -3, 5, 6, -3, 7, 8]

for i in range(len(nums) - 1):
    if nums[i] * nums[i+1] > 0: 
        print(nums[i], nums[i+1])
