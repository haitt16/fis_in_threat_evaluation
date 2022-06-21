# Using Fuzzy Inference System for Target Threat Evaluation Problem

Đây là toàn bộ mã nguồn cho mô hình `fis` giải quyết bài toán đánh giá mức độ nguy hiểm của mục tiêu trong ứng dụng quốc phòng. Bài báo cáo giới thiệu chi tiết mô hình `fis` xem tại [link](google.com) này. Mã nguồn được chia làm 3 phần:
- [FIS Models](./model/)
- [Dữ liệu Test](./test/)
- [Bộ quy tắc](./rulebox/)

Toàn bộ mô hình được xây dựng sử dụng phần mềm MATLAB 2020a. Các hướng dẫn sau đây cũng sử dụng các script của phần mềm này.

## FIS Model

Xây dựng thử nghiệm 3 mô hình, trong đó các mô hình chỉ khác nhau ở phương pháp Aggregation hay `AggregationMethod` bao gồm `probor`, `sum`, `max`.
Các tên file mô hình có dạng như sau:\\
`ThreatEvaluation_<AgrregationMethod>.fis`

## Dữ liệu Test
Bộ dữ liệu test bao gồm 3 tình huống mô phỏng khác nhau. 
- Tình huống 1: `mục tiêu` tiếp cận ngày càng gần `tài sản phòng thủ`.
- Tình huống 2: `mục tiêu` ra xa dần rồi lại đổi hướng tiếp cận gần `tài sản phòng thủ`.
- Tình huống 3: `mục tiêu` tiếp cận gần rồi lại ra xa dần `tài sản phòng thủ`.

## Bộ quy tắc

Bộ quy tắc gồm các dòng dãy số thể hiện các hàm liên thuộc chỉ mức độ ứng lên mỗi thuộc tính theo thứ tự lần lượt. Ngoài ra còn có các tham số đặc trưng khác cho một câu quy tắc như `weights` và `operator` giữa các hàm liên thuộc được chọn trong câu. Như vậy mỗi câu quy tắc có dạng:
`

```
<speed> <altitude> <cpa> <tbh> <iff>, <threat> (<weight>) : <operator>
```

### <operator> 
Số `1` biểu diễn cho toán tử `and`, số `2` biểu diễn cho toán tử `or`.
### Bảng mức độ ứng với các số 
| Index |  speed   |   altitude   |   cpa   |   tbh  |   iff   | threat |
| ----- | -------- | ------------ | ------- | ------ | ------- | ------ |
|   0   |   none   |     none     |   none  |   none |   none  | NA |
|   1   |   slow   | low | veryshort | veryshort | friend | low |
|   2   | medium | medium | short | short | foe | medium |
|   3   | fast | high | medium | medium | NA | high |
|   4   | veryfast | veryhigh | far | long | NA | veryhigh |

```
Note: Với các số âm (vd -1) trong câu quy tắc, dấu `-` biểu hiện cho toán tử `not`.
```

### Ví dụ:
Ta sẽ dịch câu quy tắc sau ra ngôn ngữ thường dùng:

```
2 -1 2 4 1, 2 (0.93) : 1
```

Dịch:
```
If (Speed is medium) and (Altitude is not low) and (cpa is short) and (tbh is long) and (iff is friend) then (threat is medium) (0.93) 
```

## Cài đặt và chạy thử

Ta cài đặt kiểm thử trong file `test.m` trong thư mục `./test/`. Các bước cài đặt và chạy thử mô hình.

Bước 1: Load data
```Matlab
data = load(<path_to_test_file>);
```
Bước 2: Load `.fis` model
```Matlab
fis = readfis(<path_to_fis>);
```
Bước 3: Plot result in line graph
```Matlab
x= zeros(length(data),1);
for i = 1:length(data)    
    x(i,1) = i;
end
plot(x,y,'-');
```
Bước 4: Run in command
```
run test.m
``` 



