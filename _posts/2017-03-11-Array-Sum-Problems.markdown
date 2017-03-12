
Given an array of integers, find k numbers such that the summation of them is equal to a target number.

Basic ideas:

- Solve two sum first.
  - If the returned results are indices, then we can use hash map.
  - If the function is supposed to return the values, we can sort the array first. Then use binary search to find these 
    two numbers on the sorted array.
- Based the solution of two sum, solve the k sum problems.

### 2Sum 

Given an array of integers, return indices of the two numbers such that they add up to a specific target.
You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example:
Given nums = [2, 7, 11, 15], target = 9,
Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].

```
public int[] twoSum(int[] numbers, int target) {
  int[] ind = new int[2];  
  HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();

  int val;
  for(int i = 0; i < numbers.length; i++){         
    val = target - numbers[i];
    if(map.containsKey(val)){//found
      ind[0] = map.get(val);
      ind[1] = i;
      break;
    } 
    map.put(numbers[i], i);
  }
  return ind;
}
```

### 3Sum

Given an array S of n integers, are there elements a, b, c in S such that a + b + c = 0? Find all unique triplets in the 
array which gives the sum of zero.

Note: The solution set must not contain duplicate triplets.

For example, given array S = [-1, 0, 1, 2, -1, -4],
A solution set is:
```
[
  [-1, 0, 1],
  [-1, -1, 2]
]
```

#### Solution

1. Sort the array first. Then, we can skip duplicated combinations easily.
1. For each number num[i], find the unique combination that sum to 0 - num[i] in the range i + 1 
   to n - 1 in O(n) time.
1. Skip duplicated numbers.

The complexity of the problem is O(n^2). 

```
    public List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums == null || nums.length < 3) {
            return result;
        }

        Arrays.sort(nums);
        int sum, pre, preLeft, preRight;
        for (int i = 0; i < nums.length - 2;) {
            for (int m = i + 1, n = nums.length - 1; m < n;) {
                preLeft = nums[m];
                preRight = nums[n];
                sum = nums[i] + nums[m] + nums[n];
                if (sum == 0) {
                    result.add(buildSolution(nums, i, m, n));
                    m++; n--;
                    //skip the same values
                    while (m <= n && preLeft == nums[m]) {
                        m++;
                    }
                    while (n >= m && preRight == nums[m]) {
                        n--;
                    }
                } else if (sum < 0) {
                    m++;
                    while (m <= n && preLeft == nums[m]) {
                        m++;
                    }
                } else {
                    n--;
                    while (n >= m && preRight == nums[m]) {
                        n--;
                    }
                }
            }

            //skip the same values
            pre = nums[i++];
            while (i < nums.length && pre == nums[i]) {
                i++;
            }
        }

        return result;
    }

    public List<Integer> buildSolution(int[] nums, int i, int m, int n) {
        List<Integer> values = new ArrayList<>();
        values.add(nums[i]);
        values.add(nums[m]);
        values.add(nums[n]);
        return values;
    }
```

### 3Sum Closest

Given an array S of n integers, find three integers in S such that the sum is closest to a given number, target. Return the sum of the three integers. You may assume that each input would have exactly one solution.

    For example, given array S = {-1 2 1 -4}, and target = 1.
    The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).

```
    public int threeSumClosest(int[] nums, int target) {
        Arrays.sort(nums);
        int min = Integer.MAX_VALUE, sum, diff, minDiff = Integer.MAX_VALUE;
        for (int i = 0; i < nums.length - 2; i++) {
            for (int m = i + 1, n = nums.length - 1; m < n;) {
                sum = nums[i] + nums[m] + nums[n];
                diff = Math.abs(sum - target);
                if (diff < minDiff) {
                    minDiff = diff;
                    min = sum;
                }
                if (sum == target) {
                    return target;
                } else if (sum < target) {
                    m++;
                } else {
                    n--;
                }
            }
        }

        return min;
    }
```
