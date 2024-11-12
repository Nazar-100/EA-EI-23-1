-- ������ 1. ������� ������ ����� �������� ������ � ����� �� �������� ����� ��� ����� 350000.00
-- ����� ������� �������: ������������� ����� (OfficeID), ���� (City) �� ������������� �������� (ManagerID).
SELECT 
    OfficeID, 
    City, 
    ManagerID
FROM 
    dbo.OFFICES
WHERE 
    Region = 'East'  -- Գ�������� ��� ����� �������� ������
    AND TargetSales <= 350000.00;  -- ֳ�� �� �������� ����� ��� ���� 350000.00


-- ������ 2.1. ������� ������ ���������, ���������� �� � 2008 ����, 
-- ����� �� � ������, �� ������������� ������ (ProductID) ������ "A" ������ �������� ��� "0" � ����-����� ����.
-- ������������ �� ������� � ������� ORDERS.
SELECT *
FROM 
    dbo.ORDERS
WHERE 
    OrderDate NOT BETWEEN '2008-01-01' AND '2008-12-31'  -- ��������� ����������, ��������� � 2008 ����
    AND (ProductID LIKE '_A%' OR ProductID LIKE '%0%');  -- �������� ����: ������ ������ "A" ��� "0" � ����-����� ����


-- ������ 2.2. ������� �������� ���� ��������� �� ��������������� ��������� (MFR) ��� ���������, 
-- ���������� �� � 2008 ����, �� ������������� ������ ������� ������ ������.
-- ����������� ������������� ��������� (MFR), ������� ���������� ��������� �� �� �������� ����.
SELECT 
    MFR, 
    COUNT(DISTINCT OrderID) AS UniqueOrders,  -- ϳ�������� ���������� ��������� ��� ������� ���������
    SUM(TotalAmount) AS TotalSum  -- ���������� �������� ���� ���������
FROM 
    dbo.ORDERS
WHERE 
    OrderDate NOT BETWEEN '2008-01-01' AND '2008-12-31'  -- ���������� ���������, ���������� � 2008 ����
    AND (ProductID LIKE '_A%' OR ProductID LIKE '%0%')  -- �������� ���� ��� �������������� ������
GROUP BY 
    MFR  -- ���������� �� ����������
ORDER BY 
    TotalSum ASC;  -- ���������� ���������� �� ��������� ����� � ������� ���������


-- ������ 2.3. ������� ������������� ��������� (MFR) � ��������� ��������� ����� ���������,
-- ���������� ����� ����������, ��������� �� � 2008 ����, �� �� ������������� ������ ������� ������ ������.
-- ������������� TOP 1 WITH TIES ��� ���������� �������� ��������� �������.
SELECT TOP 1 WITH TIES
    MFR, 
    SUM(TotalAmount) AS TotalSum  -- ���������� �������� ���� ��������� ��� ������� ���������
FROM 
    dbo.ORDERS
WHERE 
    OrderDate NOT BETWEEN '2008-01-01' AND '2008-12-31'  -- ���������� ���������, ���������� � 2008 ����
    AND (ProductID LIKE '_A%' OR ProductID LIKE '%0%')  -- �������� ���� ��� �������������� ������
GROUP BY 
    MFR  -- ���������� �� ����������
ORDER BY 
    TotalSum DESC;  -- ���������� �� ��������� ��� ��������� �������� ����


-- ������ 3. ������� ������������� ����� � ��������� ������� ���������� �� ����� "Sales Rep"
-- ���� 29, 45 ��� 48 ����. ��������������� TOP 1 WITH TIES ��� ���������� ������� � ��������� ������� ����������.
SELECT TOP 1 WITH TIES
    OfficeID, 
    COUNT(*) AS EmployeeCount  -- ϳ�������� ������� ����������, �� ���������� ������
FROM 
    dbo.SALESREPS
WHERE 
    Position = 'Sales Rep'  -- Գ�������� �� ������� "Sales Rep"
    AND Age IN (29, 45, 48)  -- Գ�������� �� ����: 29, 45 ��� 48 ����
GROUP BY 
    OfficeID  -- ���������� �� ��������������� �����
ORDER BY 
    EmployeeCount DESC;  -- ���������� �� ������� ���������� � ������� ��������
