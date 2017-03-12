There are two sorted arrays nums1 and nums2 of size m and n respectively.

Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

Example 1:
```
nums1 = [1, 3]
nums2 = [2]
The median is 2.0
```

Example 2:
```
nums1 = [1, 2]
nums2 = [3, 4]
The median is (2 + 3)/2 = 2.5
```

#### Analysis

Since the arrays are sorted. We can try to merge half of the two arrays without copying values.
We only need to store the last two visited values.

```
    public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        int len = nums1.length + nums2.length;
        if (len == 1) {
            return nums1.length == 0 ? nums2[0] : nums1[0];
        }

        int i = 0, //points to nums1
            j = 0, //points to nums2
            k = (nums1.length + nums2.length) / 2;

        int[] last = {0, 0};
        for (int p = 0; p <= k; p++) {
            if (i < nums1.length && j < nums2.length) {
                if (nums1[i] <= nums2[j]) {
                    last[p%2] = nums1[i];
                    i++;
                } else {
                    last[p%2] = nums2[j];
                    j++;
                }
            } else if (i < nums1.length) {
                last[p%2] = nums1[i];
                i++;
            } else { // j < nums2.length
                last[p%2] = nums2[j];
                j++;
            }
        }

        if ((len % 2) == 0) {
            return (last[0] + last[1]) / 2.0;
        } else {
            return last[k%2];
        }
    }
```
