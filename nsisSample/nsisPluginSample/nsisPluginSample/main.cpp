#include <Windows.h>
#include <tchar.h>
#include "pluginapi.h"
#include "resource.h"

//プロトタイプ宣言
LRESULT  CALLBACK   WndProc(HWND, UINT, WPARAM, LPARAM);
int      WINAPI     WinMain(HINSTANCE, HINSTANCE, LPSTR, int);
void showBmp(HWND hWnd, HDC hdc);

HINSTANCE g_hInstance;

extern "C" void __declspec(dllexport) sayHello (HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra)
{
	EXDLL_INIT();
	
	MessageBox(hwndParent, "こんにちはこんにちは！", "Hello world!", MB_OK);
}

extern "C" void __declspec(dllexport) messageBox (HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra)
{
	EXDLL_INIT();
	
	char title[1024];
	popstring(title); // 引数の1つ目
	char message[1024];
	popstring(message); // 引数の2つ目
	
	MessageBox(hwndParent, title, message, MB_OK);
}

extern "C" void __declspec(dllexport) showMami(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra)
{
	EXDLL_INIT();	
	// Set up and register window class
	WNDCLASS wc = {
		CS_CLASSDC | CS_HREDRAW | CS_VREDRAW,
		WndProc, 0, 0, g_hInstance, NULL, LoadCursor( NULL, IDC_ARROW ),
		(HBRUSH) GetStockObject( WHITE_BRUSH ), NULL, "sampleWindow"
	};
	if( RegisterClass( &wc ) == 0 ) {
		return;
	}

	//ウインドウ生成
    HWND hWnd = CreateWindow(
			"sampleWindow", "sampleWindow", WS_MAXIMIZE | WS_VISIBLE,
			CW_USEDEFAULT, CW_USEDEFAULT,
			CW_USEDEFAULT, CW_USEDEFAULT,
			NULL, NULL, g_hInstance, NULL
		);

    if ( hWnd ) {
		ShowWindow(hWnd, SW_MAXIMIZE); //Window表示
		SetMenu(hWnd, NULL);	//メニューを隠す
		SetWindowLong(hWnd, GWL_STYLE, WS_VISIBLE | WS_POPUP);
		HMONITOR hMonitor = MonitorFromWindow(hWnd, MONITOR_DEFAULTTOPRIMARY);
		MONITORINFO monitorInfo;
		monitorInfo.cbSize = sizeof(monitorInfo);
		BOOL res = GetMonitorInfo(hMonitor, &monitorInfo);
		MoveWindow(hWnd,
			monitorInfo.rcMonitor.left,
			monitorInfo.rcMonitor.top,
			monitorInfo.rcMonitor.right - monitorInfo.rcMonitor.left,
			monitorInfo.rcMonitor.bottom - monitorInfo.rcMonitor.top,
			TRUE);
		UpdateWindow( hWnd ); //表示を初期化
		SetFocus( hWnd ); //フォーカスを設定
    
		MSG msg;
		while( GetMessage( &msg, NULL, 0, 0 ) ){
			TranslateMessage( &msg );
			DispatchMessage( &msg );
		}
	}
}


BOOL WINAPI DllMain(HINSTANCE hInstance, ULONG ul_reason_for_call, LPVOID lpReserved){
	g_hInstance = hInstance;
	return TRUE;
}

// for test
int  WINAPI  WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow ){
	g_hInstance = hInstance;
	showMami(NULL, 0, NULL, NULL, NULL);
}


//Windws イベント用関数
LRESULT  CALLBACK  WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam){
    //渡された message から、イベントの種類を解析する
    switch(msg){
	case WM_PAINT:
		{
			PAINTSTRUCT ps;
			HDC hdc = BeginPaint(hWnd, &ps);
			showBmp(hWnd, hdc);
			EndPaint(hWnd, &ps);
		}
		break;
	case WM_LBUTTONDOWN:
        PostQuitMessage(0);
		break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    
    //----デフォルトの処理----
    default :
        return DefWindowProc(hWnd,msg,wParam,lParam);
    }
	return 0L;
}

void showBmp(HWND hWnd, HDC hdc) {
	HDC hmdc;
    HBITMAP hBitmap;
    BITMAP bmp;
    int BMP_W, BMP_H;

    HINSTANCE hInst = (HINSTANCE)GetWindowLong(hWnd, GWL_HINSTANCE);
    hBitmap = LoadBitmap(g_hInstance, MAKEINTRESOURCE(IDB_BITMAP_MAMI));
    GetObject(hBitmap, sizeof(BITMAP), &bmp);
    hmdc = CreateCompatibleDC(hdc);
    SelectObject(hmdc, hBitmap);
	
	HMONITOR hMonitor = MonitorFromWindow(hWnd, MONITOR_DEFAULTTOPRIMARY);
	MONITORINFO monitorInfo;
	monitorInfo.cbSize = sizeof(monitorInfo);
	BOOL res = GetMonitorInfo(hMonitor, &monitorInfo);

	int monitorWidth = monitorInfo.rcMonitor.right - monitorInfo.rcMonitor.left;
	int delta = monitorWidth - bmp.bmWidth;
	BitBlt(hdc, 
		delta / 2,
		monitorInfo.rcMonitor.top,
		bmp.bmWidth,
		bmp.bmHeight,
		hmdc, 0, 0, SRCCOPY);
    DeleteDC(hmdc);
    DeleteObject(hBitmap);
    return;
}