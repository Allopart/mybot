require 'torch'
require 'image'
require 'optim'
require 'cunn'
require 'cutorch'

input=torch.Tensor(inputMat)
input = input:cuda()


for i = 1,(#input)[1] do
	input[i]=image.rgb2yuv(input[i])
end


for i=1,channel[class] do
  
	input[{ {},i,{},{} }]:add(-mean[class][i])
	input[{ {},i,{},{} }]:div(std[class][i])
end


pred = full_model:forward(input)

val,index = torch.max(pred,2)
label = index[{{},1}]
value = val[{{},1}]
label[value:lt(logProb)]=0


