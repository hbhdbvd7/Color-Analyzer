# CPU 便携版运行说明

解压完整 ZIP 后直接运行 `Color Analyzer.exe`，不要只复制 EXE。Qt DLL、`platforms`、`imageformats`、OpenImageIO 及其依赖必须保持原有相对目录结构。

目标环境为 Windows 10 22H2 或 Windows 11 x64。用户不需要安装 Qt、OpenImageIO、CUDA Toolkit、CMake、Visual Studio 或配置环境变量；运行时依赖随包部署。

本版本的所有静帧分析、色彩变换、LUT 处理和示波器统计均在 CPU 上执行，不探测、不加载、不链接 CUDA。没有 NVIDIA 显卡也不会影响功能。

若 Windows 对下载的 ZIP 显示安全拦截，请先在 ZIP 文件属性中选择“解除锁定”，再完整解压。
