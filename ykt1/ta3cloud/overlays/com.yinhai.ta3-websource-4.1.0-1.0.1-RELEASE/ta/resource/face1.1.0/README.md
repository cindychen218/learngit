### 1.版本修改

如果前端版本需求切换到其他版本,在 config.properties中`FaceVersion=face1.1.0`修改到对应的版本号.

### 2.框架FACE目录介绍

#### chunk
    按需加载的组件需要的js资源
#### fonts
    字体图标资源
#### i18n
    国际化资源
#### lib

    可选引入组件，与框架无直接关系

| 组件名 | 描述 | 引入情况 |
| -------------|-------------| -------------|
| clientEnvironment | 环境感知 | 开发人员视情况引入 |
| echart | echart 图标工具（2.0版本） | 开发人员视情况引入 |
| echart3.0 | echart 图标工具（3.0版本） | 开发人员视情况引入 |
| ueditor | 百度的富文本组件 | 开发人员视情况引入 |
| Colorpicker | 颜色选择组件 | 开发人员视情况引入 |
| runqian | 润乾报表相关 | 开发人员视情况引入 |
| w2uiGrid | 一个表格插件 | 开发人员视情况引入 |

#### skin
框架默认三套皮肤的样式

#### support

    支持框架组件正常工作的基础组件或模块

| 组件名 | 描述 | 引入情况 |
| -------------|-------------| -------------|
| crossDomain | 跨域支持 | 框架引入 |
| filepreview | 文件浏览组件支持 | 框架引入 |
| helpTip | 页面时显示向导支持 | 框架引入 |
| i18n   | 国际化支持 | 框架引入 |
| indexWindow | 首页js方法支持 | 框架引入 |
| jquery | jquery库 | 框架引入 |
| layDate | layDate日期组件支持 | 框架引入 |
| pdfjs | pdf预览支持 | 框架引入 |
| taCompatible | 前端兼容包 | 开发人员视情况引入 |
| wangEditor | richText富文本框支持 | 框架引入 |
| wdatepicher | 日期组件支持 | 框架引入 |
| webuploader | uploader上传组件支持 | 框架引入 |



### 3.前端样式覆盖指南

  项目样式覆盖以及js功能覆盖一律写在
  `ta3-peoject-ta3/src/main/webapp/indexSRC/project_cover/`下面.

  `component_cover`文档下是框架组件css样式以及框架js功能覆盖文档.

  `index_cover`文档下是index首页`index.jsp`css样式以及index首页`index.jsp` js功能覆盖文档.

  `login_cover`文档下是登陆页`login.jsp`css样式以及登陆页`login.jsp` js功能覆盖文档

#### 3.1. 框架组件css样式以及组件js功能覆盖

  在`component_cover`中的`component_cover.css`样式文档中添加修改样式.


  在`component_cover`中的`component_cover.js`js文档中添加js组件方法覆盖.

  然后在`appinc.jsp` 中解注释

  	 <%--引入项目组件样式覆盖文件--%>
  	 <link rel="stylesheet" type="text/css" href="${basePath}indexSRC/project_cover/component_cover/component_cover.css" />
  	 <%--引入项目js功能覆盖文件--%>
  	 <script src="${basePath}indexSRC/project_cover/component_cover/component_cover.js" type="text/javascript"></script>


#### 3.2. index首页css样式以及首页js功能覆盖

  在`index_cover`中的`index_cover.css`样式文档中添加修改样式.


  在`index_cover`中的`index_cover.js`js文档中添加js组件方法覆盖.

  然后在`index.jsp` 中解注释

      <%--引入项目主页覆盖文件--%>
      <link rel="stylesheet" type="text/css" href="${basePath}indexSRC/project_cover/index_cover/index_cover.css" />
      <%--引入项目主页js功能覆盖文件--%>
      <script src="${basePath}indexSRC/project_cover/index_cover/index_cover.js" type="text/javascript"></script>
#### 3.3 login登陆页css样式覆盖

  在`login_cover`中的`login_cover.css`样式文档中添加修改样式.

  然后在`login.jsp` 中解注释

      <%--登陆页面样式覆盖--%>
      <link href="${pageContext.servletContext.contextPath }/indexSRC/project_cover/login_cover/login_cover.css" rel="stylesheet"  />