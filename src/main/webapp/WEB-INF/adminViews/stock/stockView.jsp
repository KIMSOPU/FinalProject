<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<p>재고현황</p>


<div class="input-group no-border">

<form name="stockmanage" method="post" action="list">
<span>
   <select id="selectTag" name="selectTag" class="form-control">
      <option value="id">브랜드별</option>
      
	  <option value="rating">나익히</option>
   	  <option value="report">숲흐림</option>
      <option value="sleepMem">옵흐하이트</option>
      <option value="report">아디도스</option>
      <option value="sleepMem">디오르</option>
   </select>
<input type= "text" id="nameInput"  >
<input id="searchBtn" type="submit" value="검색" >
</span>
</form>   



</span></div></form>




<div class="col-md-12">
            <div class="card card-plain">
              <div class="card-header">
                <h4 class="card-title"> </h4>
                <p class="card-category"> </p>
              </div>
              <div class="card-body">
                <div class="table-responsive">
                  <table class="table">
                    <thead class=" text-primary">
                      <tr><th>
                        상품번호
                      </th>
                      <th>
                        기존재고
                      </th>
                      <th>
                        입고량
                      </th>
                       <th>
                       	입고날짜
                      </th>
                       <th>
                        출고량
                      </th>
                       <th>
                        출고날짜
                      </th>
                       <th>
                        현재고
                      </th>
                     
                    </tr></thead>
                    <tbody>
                      <tr>
                        <td>
                          Dakota Rice
                        </td>
                        <td>
                          Niger
                        </td>
                        <td>
                          Oud-Turnhout
                        </td>
                        <td class="text-right">
                          $36,738
                        </td>
                      </tr>
                      <tr>
                        <td>
                          Minerva Hooper
                        </td>
                        <td>
                          Curaçao
                        </td>
                        <td>
                          Sinaai-Waas
                        </td>
                        <td class="">
                          
                        </td>
                      </tr>
                      <tr>
                        <td>
                          Sage Rodriguez
                        </td>
                        <td>
                          Netherlands
                        </td>
                        <td>
                          Baileux
                        </td>
                        <td class="text-right">
                          $56,142
                        </td>
                      </tr>
                      <tr>
                        <td>
                          Philip Chaney
                        </td>
                        <td>
                          Korea, South
                        </td>
                        <td>
                          Overland Park
                        </td>
                        <td class="text-right">
                          $38,735
                        </td>
                      </tr>
                      <tr>
                        <td>
                          Doris Greene
                        </td>
                        <td>
                          Malawi
                        </td>
                        <td>
                          Feldkirchen in Kärnten
                        </td>
                        <td class="text-right">
                          $63,542
                        </td>
                      </tr>
                      <tr>
                        <td>
                          Mason Porter
                        </td>
                        <td>
                          Chile
                        </td>
                        <td>
                          Gloucester
                        </td>
                        <td class="text-right">
                          $78,615
                        </td>
                      </tr>
                      <tr>
                        <td>
                          Jon Porter
                        </td>
                        <td>
                          Portugal
                        </td>
                        <td>
                          Gloucester
                        </td>
                        <td class="text-right">
                          $98,615
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
          </div>



</body>
</html>