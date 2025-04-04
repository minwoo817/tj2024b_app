void main(){
  int number = 31;
  if(number % 2 == 1){
    print("홀수!");
  }else{
    print("짝수!");
  }
  String light = "red";
  if(light == "green"){
    print("초록불");
  }else if(light == "yellow"){
    print("노랑불");
  }else if(light == "red"){
    print("빨간불");
  }else{
    print("잘못된 신호입니다.");
  }
  String light1 = "purple";
  if(light1 == "green"){
    print("초록불");
  }else if(light1 == "yellow"){
    print("노랑불");
  }else if(light1 == "red"){
    print("빨간불");
  }
  for(int i = 0; i < 100; i++){
    print(i+1);
  }
  List<String> subjects = ['자료구조', '이산수학', '알고리즘', '플러터'];
  for(String subject in subjects){
    print(subject);
  }
  int i = 0;
  while(i<100){
    print(i+1);
    i = i + 1;
  }
  int j = 0;
  while(true){
    print(j+1);
    j = j + 1;
    break;
  }
  int k = 0;
  while(true){
    print(k+1);
    k = k + 1;
    if(k == 100){
      break;
    }
  }
  for(int i = 0; i < 100; i++){
    if(i%2 == 0){
      continue;
    }
    print(i+1);
  }

  int number1 = add(1, 2);
  print(number1);
  switch(number){
    case 1:
      print('one');
  }

  const a = 'a';
  const b = 'b';
  const obj = [a, b];
  switch(obj){
    case[a, b]:
      print('$a, $b');
  }
  const obj1 = 1;
  const first = 1;
  const last = 4;
  switch(obj1){
    // Matches if 1 == obj1
    case 1:
      print('one');
    // Matches if the value of obj is between the constant values of first and last;
    case >= first && <= last:
      print('in range');
    // Matches if obj is a record with two fields, then assigns the fields to 'a' and 'b'
    case(var a, var b):
      print('a = $a , b = $b');

    default:
  }

}
int add(int a, int b){
  return a + b;
}