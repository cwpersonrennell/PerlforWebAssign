class ComplexN{
  constructor(re,im){
  this.re = re;
  this.im = im;
  }
  
  multiply(other){
    return new ComplexN(this.re*other.re-this.im*other.im,this.re*other.im+this.im*other.re);
  }
  
  add(other){
    return new ComplexN(this.re+other.re,this.im+other.im);
  }
  
  subtract(other){
    return new ComplexN(this.re - other.re, this.im - other.im);
  }
  
  copy(){
    return new ComplexN(this.re,this.im);
  }
  pow(n){
    let result = new ComplexN(1,0);
    for(let i = 0;i<n;i++){
      result = result.multiply(result);
    }
    return result;
  }
}
