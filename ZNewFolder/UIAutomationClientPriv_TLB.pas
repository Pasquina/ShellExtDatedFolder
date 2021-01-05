unit UIAutomationClientPriv_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 98336 $
// File generated on 1/3/2021 10:17:34 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Windows\SysWOW64\UIAutomationCore.dll\4 (1)
// LIBID: {6271895B-E67F-4DEE-B68B-BF74ACE07753}
// LCID: 0
// Helpfile: 
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// Parent TypeLibrary:
//   (0) v1.0 ZNewFolder, (C:\Users\VydarenyM\Documents\Projects\Commercial\ShellExtDatedFolder\ZNewFolder\ZNewFolder)
// SYS_KIND: SYS_WIN32
// Errors:
//   Hint: Parameter 'unit' of IUIAutomationTextRange.Move changed to 'unit_'
//   Hint: Parameter 'unit' of IUIAutomationTextRange.MoveEndpointByUnit changed to 'unit_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Winapi.ActiveX;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  UIAutomationClientPrivMajorVersion = 1;
  UIAutomationClientPrivMinorVersion = 0;

  LIBID_UIAutomationClientPriv: TGUID = '{6271895B-E67F-4DEE-B68B-BF74ACE07753}';

  IID_IMiniHwndProxy: TGUID = '{393F766C-D5EF-4CBA-BB23-935166DC30B8}';
  IID_IUIAutomationElementInternal: TGUID = '{704DA7B3-C469-4D5A-9C4B-906CA89315A9}';
  IID_IUIAutomationCacheRequest: TGUID = '{B32A92B5-BC25-4078-9C08-D7EE95C48E03}';
  IID_IUIAutomationCondition: TGUID = '{352FFBA8-0973-437C-A61F-F64CAFD81DF9}';
  IID_IUIAutomationElement: TGUID = '{D22108AA-8AC5-49A5-837B-37BBB3D7591E}';
  IID_IUIAutomationElementArray: TGUID = '{14314595-B4BC-4055-95F2-58F2E42C9855}';
  IID_IUIAutomationElementVisualRelative: TGUID = '{A572F832-778E-48E6-B358-1537749936F3}';
  IID_IUIAutomationTextReadingRange: TGUID = '{21063AD6-EC07-4414-90AD-EA51394BF3D0}';
  IID_IUIAutomationTextRange: TGUID = '{A543CC6A-F4AE-494B-8239-C814481187A8}';
  IID_IUIAutomationTextRangeVisualRelative: TGUID = '{DF8B3B0E-148E-4AD2-AE14-F809766A6746}';
  IID_IVisualRelativeRectangleArray: TGUID = '{936A9DD4-1837-4F02-BD8C-F2DF912BF49A}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum TreeScope
type
  TreeScope = TOleEnum;
const
  TreeScope_None = $00000000;
  TreeScope_Element = $00000001;
  TreeScope_Children = $00000002;
  TreeScope_Descendants = $00000004;
  TreeScope_Parent = $00000008;
  TreeScope_Ancestors = $00000010;
  TreeScope_Subtree = $00000007;

// Constants for enum AutomationElementMode
type
  AutomationElementMode = TOleEnum;
const
  AutomationElementMode_None = $00000000;
  AutomationElementMode_Full = $00000001;

// Constants for enum OrientationType
type
  OrientationType = TOleEnum;
const
  OrientationType_None = $00000000;
  OrientationType_Horizontal = $00000001;
  OrientationType_Vertical = $00000002;

// Constants for enum TextPatternRangeEndpoint
type
  TextPatternRangeEndpoint = TOleEnum;
const
  TextPatternRangeEndpoint_Start = $00000000;
  TextPatternRangeEndpoint_End = $00000001;

// Constants for enum TextUnit
type
  TextUnit = TOleEnum;
const
  TextUnit_Character = $00000000;
  TextUnit_Format = $00000001;
  TextUnit_Word = $00000002;
  TextUnit_Line = $00000003;
  TextUnit_Paragraph = $00000004;
  TextUnit_Page = $00000005;
  TextUnit_Document = $00000006;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IMiniHwndProxy = interface;
  IUIAutomationElementInternal = interface;
  IUIAutomationCacheRequest = interface;
  IUIAutomationCondition = interface;
  IUIAutomationElement = interface;
  IUIAutomationElementArray = interface;
  IUIAutomationElementVisualRelative = interface;
  IUIAutomationTextReadingRange = interface;
  IUIAutomationTextRange = interface;
  IUIAutomationTextRangeVisualRelative = interface;
  IVisualRelativeRectangleArray = interface;

// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  wireHWND = ^_RemotableHandle; 
  PPUserType1 = ^IUIAutomationElementArray; {*}
  PUserType1 = ^TGUID; {*}
  PPUserType2 = ^IUIAutomationElement; {*}


  __MIDL_IWinTypes_0009 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: Integer);
  end;

  _RemotableHandle = record
    fContext: Integer;
    u: __MIDL_IWinTypes_0009;
  end;

  tagRECT = record
    left: Integer;
    top: Integer;
    right: Integer;
    bottom: Integer;
  end;

  tagPOINT = record
    x: Integer;
    y: Integer;
  end;

{$ALIGN 8}
  UiaRect = record
    left: Double;
    top: Double;
    width: Double;
    height: Double;
  end;

  UiaVisualReferenceId = record
    Value: Largeuint;
  end;

  UiaVisualRelativeRectangle = record
    Rect: UiaRect;
    VisualReferenceId: UiaVisualReferenceId;
  end;

  UiaPoint = record
    x: Double;
    y: Double;
  end;

  UiaVisualRelativePoint = record
    Point: UiaPoint;
    VisualReferenceId: UiaVisualReferenceId;
  end;


// *********************************************************************//
// Interface: IMiniHwndProxy
// Flags:     (256) OleAutomation
// GUID:      {393F766C-D5EF-4CBA-BB23-935166DC30B8}
// *********************************************************************//
  IMiniHwndProxy = interface(IUnknown)
    ['{393F766C-D5EF-4CBA-BB23-935166DC30B8}']
    function GetWindow(out pHwnd: wireHWND): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationElementInternal
// Flags:     (256) OleAutomation
// GUID:      {704DA7B3-C469-4D5A-9C4B-906CA89315A9}
// *********************************************************************//
  IUIAutomationElementInternal = interface(IUnknown)
    ['{704DA7B3-C469-4D5A-9C4B-906CA89315A9}']
    function GetFocusedDescendantBuildCache(const cacheRequest: IUIAutomationCacheRequest; 
                                            out element: IUIAutomationElement): HResult; stdcall;
    function DescendantFromPointBuildCache(pt: tagPOINT; 
                                           const cacheRequest: IUIAutomationCacheRequest; 
                                           out element: IUIAutomationElement): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationCacheRequest
// Flags:     (0)
// GUID:      {B32A92B5-BC25-4078-9C08-D7EE95C48E03}
// *********************************************************************//
  IUIAutomationCacheRequest = interface(IUnknown)
    ['{B32A92B5-BC25-4078-9C08-D7EE95C48E03}']
    function AddProperty(propertyId: SYSINT): HResult; stdcall;
    function AddPattern(patternId: SYSINT): HResult; stdcall;
    function Clone(out clonedRequest: IUIAutomationCacheRequest): HResult; stdcall;
    function Get_TreeScope(out scope: TreeScope): HResult; stdcall;
    function Set_TreeScope(scope: TreeScope): HResult; stdcall;
    function Get_TreeFilter(out filter: IUIAutomationCondition): HResult; stdcall;
    function Set_TreeFilter(const filter: IUIAutomationCondition): HResult; stdcall;
    function Get_AutomationElementMode(out mode: AutomationElementMode): HResult; stdcall;
    function Set_AutomationElementMode(mode: AutomationElementMode): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationCondition
// Flags:     (0)
// GUID:      {352FFBA8-0973-437C-A61F-F64CAFD81DF9}
// *********************************************************************//
  IUIAutomationCondition = interface(IUnknown)
    ['{352FFBA8-0973-437C-A61F-F64CAFD81DF9}']
  end;

// *********************************************************************//
// Interface: IUIAutomationElement
// Flags:     (0)
// GUID:      {D22108AA-8AC5-49A5-837B-37BBB3D7591E}
// *********************************************************************//
  IUIAutomationElement = interface(IUnknown)
    ['{D22108AA-8AC5-49A5-837B-37BBB3D7591E}']
    function SetFocus: HResult; stdcall;
    function GetRuntimeId(out runtimeId: PSafeArray): HResult; stdcall;
    function FindFirst(scope: TreeScope; const condition: IUIAutomationCondition; 
                       out found: IUIAutomationElement): HResult; stdcall;
    function FindAll(scope: TreeScope; const condition: IUIAutomationCondition; 
                     out found: PPUserType1): HResult; stdcall;
    function FindFirstBuildCache(scope: TreeScope; const condition: IUIAutomationCondition; 
                                 const cacheRequest: IUIAutomationCacheRequest; 
                                 out found: IUIAutomationElement): HResult; stdcall;
    function FindAllBuildCache(scope: TreeScope; const condition: IUIAutomationCondition; 
                               const cacheRequest: IUIAutomationCacheRequest; 
                               out found: IUIAutomationElementArray): HResult; stdcall;
    function BuildUpdatedCache(const cacheRequest: IUIAutomationCacheRequest; 
                               out updatedElement: IUIAutomationElement): HResult; stdcall;
    function GetCurrentPropertyValue(propertyId: SYSINT; out retVal: OleVariant): HResult; stdcall;
    function GetCurrentPropertyValueEx(propertyId: SYSINT; ignoreDefaultValue: Integer; 
                                       out retVal: OleVariant): HResult; stdcall;
    function GetCachedPropertyValue(propertyId: SYSINT; out retVal: OleVariant): HResult; stdcall;
    function GetCachedPropertyValueEx(propertyId: SYSINT; ignoreDefaultValue: Integer; 
                                      out retVal: OleVariant): HResult; stdcall;
    function GetCurrentPatternAs(patternId: SYSINT; var riid: TGUID; out patternObject: Pointer): HResult; stdcall;
    function GetCachedPatternAs(patternId: SYSINT; var riid: TGUID; out patternObject: Pointer): HResult; stdcall;
    function GetCurrentPattern(patternId: SYSINT; out patternObject: IUnknown): HResult; stdcall;
    function GetCachedPattern(patternId: SYSINT; out patternObject: IUnknown): HResult; stdcall;
    function GetCachedParent(out parent: IUIAutomationElement): HResult; stdcall;
    function GetCachedChildren(out children: IUIAutomationElementArray): HResult; stdcall;
    function Get_CurrentProcessId(out retVal: SYSINT): HResult; stdcall;
    function Get_CurrentControlType(out retVal: SYSINT): HResult; stdcall;
    function Get_CurrentLocalizedControlType(out retVal: WideString): HResult; stdcall;
    function Get_CurrentName(out retVal: WideString): HResult; stdcall;
    function Get_CurrentAcceleratorKey(out retVal: WideString): HResult; stdcall;
    function Get_CurrentAccessKey(out retVal: WideString): HResult; stdcall;
    function Get_CurrentHasKeyboardFocus(out retVal: Integer): HResult; stdcall;
    function Get_CurrentIsKeyboardFocusable(out retVal: Integer): HResult; stdcall;
    function Get_CurrentIsEnabled(out retVal: Integer): HResult; stdcall;
    function Get_CurrentAutomationId(out retVal: WideString): HResult; stdcall;
    function Get_CurrentClassName(out retVal: WideString): HResult; stdcall;
    function Get_CurrentHelpText(out retVal: WideString): HResult; stdcall;
    function Get_CurrentCulture(out retVal: SYSINT): HResult; stdcall;
    function Get_CurrentIsControlElement(out retVal: Integer): HResult; stdcall;
    function Get_CurrentIsContentElement(out retVal: Integer): HResult; stdcall;
    function Get_CurrentIsPassword(out retVal: Integer): HResult; stdcall;
    function Get_CurrentNativeWindowHandle(out retVal: Pointer): HResult; stdcall;
    function Get_CurrentItemType(out retVal: WideString): HResult; stdcall;
    function Get_CurrentIsOffscreen(out retVal: Integer): HResult; stdcall;
    function Get_CurrentOrientation(out retVal: OrientationType): HResult; stdcall;
    function Get_CurrentFrameworkId(out retVal: WideString): HResult; stdcall;
    function Get_CurrentIsRequiredForForm(out retVal: Integer): HResult; stdcall;
    function Get_CurrentItemStatus(out retVal: WideString): HResult; stdcall;
    function Get_CurrentBoundingRectangle(out retVal: tagRECT): HResult; stdcall;
    function Get_CurrentLabeledBy(out retVal: IUIAutomationElement): HResult; stdcall;
    function Get_CurrentAriaRole(out retVal: WideString): HResult; stdcall;
    function Get_CurrentAriaProperties(out retVal: WideString): HResult; stdcall;
    function Get_CurrentIsDataValidForForm(out retVal: Integer): HResult; stdcall;
    function Get_CurrentControllerFor(out retVal: IUIAutomationElementArray): HResult; stdcall;
    function Get_CurrentDescribedBy(out retVal: IUIAutomationElementArray): HResult; stdcall;
    function Get_CurrentFlowsTo(out retVal: IUIAutomationElementArray): HResult; stdcall;
    function Get_CurrentProviderDescription(out retVal: WideString): HResult; stdcall;
    function Get_CachedProcessId(out retVal: SYSINT): HResult; stdcall;
    function Get_CachedControlType(out retVal: SYSINT): HResult; stdcall;
    function Get_CachedLocalizedControlType(out retVal: WideString): HResult; stdcall;
    function Get_CachedName(out retVal: WideString): HResult; stdcall;
    function Get_CachedAcceleratorKey(out retVal: WideString): HResult; stdcall;
    function Get_CachedAccessKey(out retVal: WideString): HResult; stdcall;
    function Get_CachedHasKeyboardFocus(out retVal: Integer): HResult; stdcall;
    function Get_CachedIsKeyboardFocusable(out retVal: Integer): HResult; stdcall;
    function Get_CachedIsEnabled(out retVal: Integer): HResult; stdcall;
    function Get_CachedAutomationId(out retVal: WideString): HResult; stdcall;
    function Get_CachedClassName(out retVal: WideString): HResult; stdcall;
    function Get_CachedHelpText(out retVal: WideString): HResult; stdcall;
    function Get_CachedCulture(out retVal: SYSINT): HResult; stdcall;
    function Get_CachedIsControlElement(out retVal: Integer): HResult; stdcall;
    function Get_CachedIsContentElement(out retVal: Integer): HResult; stdcall;
    function Get_CachedIsPassword(out retVal: Integer): HResult; stdcall;
    function Get_CachedNativeWindowHandle(out retVal: Pointer): HResult; stdcall;
    function Get_CachedItemType(out retVal: WideString): HResult; stdcall;
    function Get_CachedIsOffscreen(out retVal: Integer): HResult; stdcall;
    function Get_CachedOrientation(out retVal: OrientationType): HResult; stdcall;
    function Get_CachedFrameworkId(out retVal: WideString): HResult; stdcall;
    function Get_CachedIsRequiredForForm(out retVal: Integer): HResult; stdcall;
    function Get_CachedItemStatus(out retVal: WideString): HResult; stdcall;
    function Get_CachedBoundingRectangle(out retVal: tagRECT): HResult; stdcall;
    function Get_CachedLabeledBy(out retVal: IUIAutomationElement): HResult; stdcall;
    function Get_CachedAriaRole(out retVal: WideString): HResult; stdcall;
    function Get_CachedAriaProperties(out retVal: WideString): HResult; stdcall;
    function Get_CachedIsDataValidForForm(out retVal: Integer): HResult; stdcall;
    function Get_CachedControllerFor(out retVal: IUIAutomationElementArray): HResult; stdcall;
    function Get_CachedDescribedBy(out retVal: IUIAutomationElementArray): HResult; stdcall;
    function Get_CachedFlowsTo(out retVal: IUIAutomationElementArray): HResult; stdcall;
    function Get_CachedProviderDescription(out retVal: WideString): HResult; stdcall;
    function GetClickablePoint(out clickable: tagPOINT; out gotClickable: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationElementArray
// Flags:     (0)
// GUID:      {14314595-B4BC-4055-95F2-58F2E42C9855}
// *********************************************************************//
  IUIAutomationElementArray = interface(IUnknown)
    ['{14314595-B4BC-4055-95F2-58F2E42C9855}']
    function Get_Length(out Length: SYSINT): HResult; stdcall;
    function GetElement(index: SYSINT; out element: IUIAutomationElement): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationElementVisualRelative
// Flags:     (256) OleAutomation
// GUID:      {A572F832-778E-48E6-B358-1537749936F3}
// *********************************************************************//
  IUIAutomationElementVisualRelative = interface(IUnknown)
    ['{A572F832-778E-48E6-B358-1537749936F3}']
    function GetVisualRelativeBoundingRectangle(out visualRelativeRect: UiaVisualRelativeRectangle): HResult; stdcall;
    function GetVisualRelativeCenterPoint(out visualRelativePoint: UiaVisualRelativePoint): HResult; stdcall;
    function GetVisualRelativeClickablePoint(out visualRelativePoint: UiaVisualRelativePoint): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationTextReadingRange
// Flags:     (256) OleAutomation
// GUID:      {21063AD6-EC07-4414-90AD-EA51394BF3D0}
// *********************************************************************//
  IUIAutomationTextReadingRange = interface(IUnknown)
    ['{21063AD6-EC07-4414-90AD-EA51394BF3D0}']
    function GetTextUnitChange(const pUIASelectedRange: IUIAutomationTextRange; 
                               out pdwEndOrEmptyDocument: LongWord; out punit: TextUnit): HResult; stdcall;
    function TrimRange(fTrimPunctuation: Integer; out ppTrimmedRange: IUIAutomationTextRange): HResult; stdcall;
    function TrimRangeLeading(fTrimPunctuation: Integer; out ppTrimmedRange: IUIAutomationTextRange): HResult; stdcall;
    function TrimRangeTrailing(fTrimPunctuation: Integer; out ppTrimmedRange: IUIAutomationTextRange): HResult; stdcall;
    function GetCharactersAroundTheCursor(out pdwCharacterPosition: LongWord; 
                                          out pbstrBefore: WideString; out pbstrAfter: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationTextRange
// Flags:     (0)
// GUID:      {A543CC6A-F4AE-494B-8239-C814481187A8}
// *********************************************************************//
  IUIAutomationTextRange = interface(IUnknown)
    ['{A543CC6A-F4AE-494B-8239-C814481187A8}']
    function Clone(out clonedRange: IUIAutomationTextRange): HResult; stdcall;
    function Compare(const range: IUIAutomationTextRange; out areSame: Integer): HResult; stdcall;
    function CompareEndpoints(srcEndPoint: TextPatternRangeEndpoint; 
                              const range: IUIAutomationTextRange; 
                              targetEndPoint: TextPatternRangeEndpoint; out compValue: SYSINT): HResult; stdcall;
    function ExpandToEnclosingUnit(TextUnit: TextUnit): HResult; stdcall;
    function FindAttribute(attr: SYSINT; val: OleVariant; backward: Integer; 
                           out found: IUIAutomationTextRange): HResult; stdcall;
    function FindText(const text: WideString; backward: Integer; ignoreCase: Integer; 
                      out found: IUIAutomationTextRange): HResult; stdcall;
    function GetAttributeValue(attr: SYSINT; out Value: OleVariant): HResult; stdcall;
    function GetBoundingRectangles(out boundingRects: PSafeArray): HResult; stdcall;
    function GetEnclosingElement(out enclosingElement: PPUserType2): HResult; stdcall;
    function GetText(maxLength: SYSINT; out text: WideString): HResult; stdcall;
    function Move(unit_: TextUnit; count: SYSINT; out moved: SYSINT): HResult; stdcall;
    function MoveEndpointByUnit(endpoint: TextPatternRangeEndpoint; unit_: TextUnit; count: SYSINT; 
                                out moved: SYSINT): HResult; stdcall;
    function MoveEndpointByRange(srcEndPoint: TextPatternRangeEndpoint; 
                                 const range: IUIAutomationTextRange; 
                                 targetEndPoint: TextPatternRangeEndpoint): HResult; stdcall;
    function Select: HResult; stdcall;
    function AddToSelection: HResult; stdcall;
    function RemoveFromSelection: HResult; stdcall;
    function ScrollIntoView(alignToTop: Integer): HResult; stdcall;
    function GetChildren(out children: IUIAutomationElementArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IUIAutomationTextRangeVisualRelative
// Flags:     (256) OleAutomation
// GUID:      {DF8B3B0E-148E-4AD2-AE14-F809766A6746}
// *********************************************************************//
  IUIAutomationTextRangeVisualRelative = interface(IUnknown)
    ['{DF8B3B0E-148E-4AD2-AE14-F809766A6746}']
    function GetVisualRelativeBoundingRectangles(out rects: IVisualRelativeRectangleArray): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IVisualRelativeRectangleArray
// Flags:     (256) OleAutomation
// GUID:      {936A9DD4-1837-4F02-BD8C-F2DF912BF49A}
// *********************************************************************//
  IVisualRelativeRectangleArray = interface(IUnknown)
    ['{936A9DD4-1837-4F02-BD8C-F2DF912BF49A}']
    function Add(Rect: UiaVisualRelativeRectangle): HResult; stdcall;
    function Get_count(out count: SYSUINT): HResult; stdcall;
    function GetAt(index: SYSUINT; out Rect: UiaVisualRelativeRectangle): HResult; stdcall;
  end;

implementation

uses System.Win.ComObj;

end.
