<%--
  Created by IntelliJ IDEA.
  User: rudeigerc
  Date: 2017/6/30
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp"%>

<div class="container">
    <div class="card">
        <div class="card-block">
            <div class="row">
                <div class="col-md-2 text-center mx-auto">
                    <img src="image/test.jpg" style="height: 100px; width: 100px;">
                </div>
                <div class="col-md-7">
                    <h4 class="card-title">rudeigerc</h4>
                    <p class="card-subtitle mb-2 text-muted">
                        <i class="fa fa-tag" aria-hidden="true"></i>&nbsp;Shanghai Jiao Tong University Software Engineering
                    </p>
                    <p class="card-subtitle mb-2 text-muted">
                        <i class="fa fa-envelope-o" aria-hidden="true"></i>&nbsp;rudeigerc@gmail.com
                    </p>
                    <p>关注人 20 · 关注者 30</p>
                </div>
                <div class="col-md-3">
                    <button class="btn btn-outline-primary center-block" type="button">
                        <i class="fa fa-pencil-square-o fa-fw" aria-hidden="true"></i>&nbsp;编辑个人资料
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="card">
        <div class="card-block">
            <ul class="nav nav-tabs" id="homepageTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="activity-tab" data-toggle="tab" href="#activity" role="tab" aria-controls="activity" aria-expanded="true">动态</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="notebook-tab" data-toggle="tab" href="#notebook" role="tab" aria-controls="notebook">笔记本</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="workgroup-tab" data-toggle="tab" href="#workgroup" role="tab" aria-controls="workgroup">工作组</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="collection-tab" data-toggle="tab" href="#collection" role="tab" aria-controls="collection">收藏</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="follow-tab" data-toggle="tab" href="#follow" role="tab" aria-controls="follow">关注</a>
                </li>
            </ul>
            <div class="tab-content" id="homepageTabContent">
                <!-- TODO: activity -->
                <div class="tab-pane fade show active" id="activity" role="tabpanel" aria-labelledby="activity-tab">activity</div>
                <!-- TODO: notebook -->
                <div class="tab-pane fade" id="notebook" role="tabpanel" aria-labelledby="notebook-tab">notebook</div>
                <!-- TODO: serverside processing -->
                <div class="tab-pane fade" id="workgroup" role="tabpanel" aria-labelledby="workgroup-tab">
                    <div class="row">
                        <div class="col-md-12" style="margin-top: 20px;">
                            <div class="row">
                                <div class="col-md-2 text-center mx-auto">
                                    <img src="image/card_1.png" style="height: 75px; width: 75px;">
                                </div>
                                <div class="col-md-7">
                                    <h4 class="card-title">Coursera Machine Learning 总结</h4>
                                    <h6 class="card-subtitle mb-2 text-muted">
                                        <i class="fa fa-tag" aria-hidden="true"></i>&nbsp;机器学习 · Logistic 回归
                                    </h6>
                                    <small>创建者 <strong>rudeigerc</strong> · 所有者 <strong>rudeigerc</strong> · 修改时间 2017-06-03 23:34:23</small>
                                    <br>
                                    <div style="margin: 10px auto;">
                                        <img src="image/test.jpg" style="width: 50px; height: 50px;">&nbsp;
                                        <img src="image/guest.png" style="width: 50px; height: 50px;">
                                    </div>
                                </div>
                                <div class="col-md-3 workgroup-btn">
                                    <a class="btn btn-outline-primary center-block" role="button" href="workgroup.jsp">
                                        <i class="fa fa-users fa-fw" aria-hidden="true"></i>&nbsp;进入工作组
                                    </a>
                                    <button class="btn btn-outline-warning center-block" type="button">
                                        <i class="fa fa-envelope-open fa-fw" aria-hidden="true"></i>&nbsp;邀请用户
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="dropdown-divider"></div>
                </div>
                <!-- TODO: collection -->
                <div class="tab-pane fade" id="collection" role="tabpanel" aria-labelledby="collection-tab">collection</div>
                <!-- TODO: follow -->
                <div class="tab-pane fade" id="follow" role="tabpanel" aria-labelledby="follow-tab">follow</div>
            </div>
        </div>
    </div>
    <footer>
        <p>&copy; 2017 TeamNote Team</p>
    </footer>
</div>

<%@ include file="footer.jsp"%>
<script type="text/javascript" src="<%=path%>/js/cooperate.js"></script>