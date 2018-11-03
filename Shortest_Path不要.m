%% Finding the Shortest Path in a Directed Graph
%1.Biograph object with 6 nodes and 11 edges.
W = [.41 .99 .51 .32 .15 .45 .38 .32 .36 .29 .21];
DG = sparse([6 1 2 2 3 4 4 5 5 6 1],[2 6 3 5 4 1 6 3 4 3 5],W);
h = view(biograph(DG,[],'ShowWeights','on'));

%2.Find the shortest path in the graph from node 1 to node 6.
[dist,path,pred] = graphshortestpath(DG,1,6); 

%3.Mark the nodes and edges of the shortest path by coloring them red and increasing the line width.
set(h.Nodes(path),'Color',[1 0.4 0.4])
edges = getedgesbynodeid(h,get(h.Nodes(path),'ID'));
set(edges,'LineColor',[1 0 0])
set(edges,'LineWidth',1.5)

