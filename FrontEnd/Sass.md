# Sass 

### 定义


##### Install sass

> npm install -g sass

##### SASS监听, 自动生成
watch a file / directory
> sass --watch input.scss:output.css

> sass --watch app/sass:public/stylesheets

### 应用

```aidl
@import "./test.scss";

$blue: #1875e7;
$side: left;
$var: 100px;
$color: #ffd49b;

@mixin left {
  float: left;
  margin-left: 10px;
}

div.left {
  @include left;
}

body {
  margin: (14px/2);
  top: 50px + 100px;
  right: $var * 10%;
  div {
    color: $blue;
    background: pink;
  }

}

.rounded {
  border-#{$side}-radius: 5px;
}

a {
  &:hover {
    color: #ffb3ff;
  }
}

.class1 {
  border: 1px solid #ddd;
}

.class2 {
  @extend .class1;
  font-size: 120%;
}

@mixin rounded($vert, $horz, $radius: 10px) {
  border-#{$vert}-#{$horz}-radius: $radius;
  -moz-border-radius-#{$vert}#{$horz}: $radius;
  -webkit-border-#{$vert}-#{$horz}-radius: $radius;
}

#nav-bar li {
  @include rounded(top, left);
}

#footer {
  @include rounded(top, left, 5px);
}

@if lightness($color) > 30% {
  background-color: #000;
} @else {
  background-color: #fff;
}
```
